Return-Path: <stable+bounces-268784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w/gnGMxIPmpxCgkAu9opvQ
	(envelope-from <stable+bounces-268784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:39:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A786CBC25
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:39:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KaZbZ040;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268784-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268784-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13192304E5C5
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3A3ED5A6;
	Fri, 26 Jun 2026 09:38:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE33EAC9F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:38:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466720; cv=none; b=KuCGWqZrwHmQyfQoXx91g2OxfTPC7Mmah4Zhejmwbsc7EiOW81THnZD8u5VNWKMl3dm0WbzLvcDNxPeJda+zqDnsL4G2zWicwgxWe4v+A0qPd97K7fy7tBSx9pUcUd1waHEOVGWWf1Ryu+HiBtyvY+Yl95kzJsTbdfkQ42g5WV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466720; c=relaxed/simple;
	bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maAl9j4IIiL2bmcWA967EWSqmvgYHh4smuY+JwtXVvMNEX4hgJfywAtXys9xHwKJ4lKi6X14Y6EjTVzY1Bc4QTy7AOz9N0b1g/8vzdkxe3CwlRFnAO2mcuhTYmGKBaIGi5lrj9n6eDpGBgtLpaTF9MRVB3z07jcFyBCSorl9VHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaZbZ040; arc=none smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aea4cbeb94so567385e87.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466714; x=1783071514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
        b=KaZbZ040pxAKh8WZxDgx4yp9V4lNiyl+iVVJgEfWGPZFj/DjnEnMYvV2Y8bwgOpjxp
         DSpV4zHeZwAxjXayA7nA63Egupll8AkPjC/WHn328Muot8u1Mw4Bt1ymuslh3DPIyI14
         vcHiFnVCO3+hjU9a6i9wwWsE/IUjwy4IDSi0woWe3eGdbz0rX1JikbB30AYCb3AT+oNE
         SnhpvseloeIwY5UPnfYGUFbRrih9XCFoqivD/O4I+qeDpkK+H9We0D24W113PrQ2+XLF
         t1HJgGs1esDe/Pb6IHRBbscO899huux84H+GMEN87NhwJBTI7G25cpgQ6y1WBblMKNRE
         Tr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466714; x=1783071514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
        b=F/Uivq9SylLpiuM0fgdYnkULAQ4BZ2pxLwgwvrHrqVuCJKht4fp/uYNgc1FLjj/6GK
         78rXtrU8BE4bwzw3ET7UnHd3nRLmejBbhsEMNnZG8D0p61yi1POONbc08+cYB/5jvPr/
         aC96oYMZP7C1qbHsnoqg/wAbZrytYBmtjHYrf1FZjA+0fDW0eE/TH5QbKxrYPE4ksBPB
         qNl5GyRhng0wqKA6T4bOc45h/tvn3g7MTDCn3HXpZIjN+zGVMJt5GIjdS0U0Iy8ushV2
         QurYNQynHQoe+6DGQDwcxiAraeLAItvWQKTWiKDjc3DmDvC4kWcGM7jR/dIxttj5680S
         644g==
X-Forwarded-Encrypted: i=1; AHgh+Rqx7pDGAuTiWsda62rEXtnzeUQqesfoLRUh4PoLlWTNeMeZFl+lrh+/cVFu4c9VvxyUgcf+iAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyfi0ZIF5NM62rad00JJudccXQ03j33PgFL9PzDsHz+GAPHzi
	ZnuQz8x3ji/ZzPk6ESTMPTPS7RUtHHuK3+rCR/wdQzzs4/zWmMM1720z
X-Gm-Gg: AfdE7cnSvLwrMcZ4nH+pAOsE4Gtl8SULBTD80A0lZg8rMwDlxOyhekvsKoV6P9ViieZ
	iiHkTB8h/ymMhYD+K4klc7JVu/VtRoSk34+LlC1BExrlKMoXptTGxdT0YMQlGxG7gldqBBonK2P
	EJy8wqGiZJdmWPKx4/cxZi+rWKZNdsFS/LswwZO5ZnME8goocqQtyBBMnx/czhsOceA8arLoF5u
	kJ0Ud2wwU9IHAebhPsyJ89Y97GVooqDxrkgdaHRBvUhTbOkwtnYU2+F242Hmh2TFIFmrhmB3DZv
	fdl1YtEk3smNjzDmT/o9A98RvtWFvVw1X5EPIVmy83+35DxKak8JhF96CXXMEo7b3PMzDMBej0E
	aujFFb3QAeCybGnDz+P8ii/h9+62Ql9RpT0Wpl5OD/O+hmAE1k0hLUWBYWkGo/3G2tFFRANMSMG
	0yCLX0rCB00UilU7V06SoYe0VcBUuA
X-Received: by 2002:ac2:51c7:0:b0:5ad:49da:67c9 with SMTP id 2adb3069b0e04-5aea1f48c2fmr1756704e87.18.1782466713996;
        Fri, 26 Jun 2026 02:38:33 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a5bfsm3270613e87.4.2026.06.26.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:38:33 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alexevgmart@gmail.com,
	bestswngs@gmail.com,
	coreteam@netfilter.org,
	davem@davemloft.net,
	fw@strlen.de,
	kaber@trash.net,
	kadlec@netfilter.org,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel,
	pablo@netfilter.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	xmei5@asu.edu,
	yoshfuji@linux-ipv6.org
Subject: Re: [PATCH v2] netfilter: nf_log: validate MAC header was set before dumping it
Date: Fri, 26 Jun 2026 12:38:20 +0300
Message-ID: <20260626093820.196664-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026062658-pregame-buggy-ccbc@gregkh>
References: <2026062658-pregame-buggy-ccbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,davemloft.net,strlen.de,trash.net,kernel.org,ms2.inr.ac.ru,vger.kernel.org,vger.kernel,asu.edu,linux-ipv6.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268784-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:bestswngs@gmail.com,m:coreteam@netfilter.org,m:davem@davemloft.net,m:fw@strlen.de,m:kaber@trash.net,m:kadlec@netfilter.org,m:kuba@kernel.org,m:kuznet@ms2.inr.ac.ru,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel,m:pablo@netfilter.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:xmei5@asu.edu,m:yoshfuji@linux-ipv6.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29A786CBC25

> What kernel(s) is this for?

5.10

