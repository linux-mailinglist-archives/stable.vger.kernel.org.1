Return-Path: <stable+bounces-264345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q2ddA1BzMWqnjgUAu9opvQ
	(envelope-from <stable+bounces-264345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:01:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F26919FC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:01:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XAEwYunC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264345-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264345-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B14D30D4AC6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ED344D6B2;
	Tue, 16 Jun 2026 15:56:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640144DB64
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:56:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625402; cv=pass; b=Gr+OiW1ClmEhmCkLGkvGVBBFuYP18yvpNoUqXZ2vscc2Z7XPS1Ypl5v0hFGoyuOKd3+2dESBRHkfucuytnJ0vrMVY6YISMgkOL4J4K759Vglxl9/B9DdKoUSqqo9LJj2xRbMPLQF2GVakvSXb6K5Pw5b6PaVS21TFg2wfeDz908=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625402; c=relaxed/simple;
	bh=Ggk0IEUcB0t7DeeS8cYHkKKJc4ICub7E45+rBcxQiGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y11F42wtaDH0DmiCWMkgYfwLkf+rjOJ7uf0MyjmrBAlKv2SRTIiCGw7tbTfV5DdWlqJlzHgmWE6p9fbx5eKNFEKVI07QKPTNyxHcRLzp9o4JVVupSiDfpf7MIGzb12JxIpX6GcLmyJ5LksNe4SI4rp07wtdTFV5OvwAX3rBhld8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAEwYunC; arc=pass smtp.client-ip=209.85.167.50
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68d9d4a3so5349261e87.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781625400; cv=none;
        d=google.com; s=arc-20240605;
        b=Gf3m9z7COH2MM06eZvnplhS5iqT6sXCOm+LZcptSeVxDWZ6ljCO4Gvys7aL2RK9ZAs
         mJzM1rWnvWtPKDtLxUTLpG1ON94GIAE8/9YC3zaf3U99UcaGfJcIMaJPg+hc4Jcn42a0
         bVOK6QiK+HEaOZ5781v3jJNtsRILnrtYITW2WDfD4yF2XmgP6Gae5OtWfL09VoQvBwAW
         /4s4glTjizlr2n/bXqa5b5oOcoAY5uR+QoaXvTWfQdo83g8NEBeDrC9MU/oUzWY4m1IV
         0gYz+OZ3UqWDflv7jO1OjIAZ/TOFzHmH2aC5WlqVvAqIz5kIX9j3Y2Ei1K5jtSj7JH7f
         r8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ggk0IEUcB0t7DeeS8cYHkKKJc4ICub7E45+rBcxQiGA=;
        fh=Ok8i7Y0FMyq7FLpK4rTIMa2Xbnf/JNj6pYwhbFhcTiA=;
        b=QWEHyzwuq7+xRcjy+0RmaG6unhQfb1vr81zINFABalhqbrxZH7gNbdfy+UuX3Iyvi9
         wm4YytXs7e+Gd6e92WxfDhPMQKfmnTvTjCrGBxTblYgLHLKPJc0yjX+tVWTOjkuqEtYX
         iXVGhnPeOTQyRxAyaBm9H+SB+eDi/sPtW0kD9qbvv29tfwTLCHqYAuuaFoWJlJyRkcxQ
         sGlCxgnACCmhTa2+uA+IkRXLHbA/iqa/XPC023ZffUCDcw/iWhDT9HTFFrU6sVwjFmOy
         mpZKoGAVe/BBZaIjaJ7pKCSPGakhWd7b/yyk2xM206G81vn2jkZmnv/++I0JixEJZoEj
         yGSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625400; x=1782230200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ggk0IEUcB0t7DeeS8cYHkKKJc4ICub7E45+rBcxQiGA=;
        b=XAEwYunC1iiArXkfTfHfuCSCZvl+WeQIMxs++Z/O/60BeIxbgFTki+gKrQwvTqhEIH
         IChiGu7scCK6/BUSTajXpwLbZJ79aqKxWND+HlvgalaM2/m6vEjx71hLQfAq++YYEmCJ
         aHlE3bCbG5f4YRLOJLsJ6/uLJMcTfofDZr3iGd0HFYlK1mziF0D2tKUDWMPn4vBscgMl
         JtZ/P2BSRylX/+Vv/hUewQTMG4Ymph4uqKdPxbYZqhg6tGQbnuJ7L/76Tjn1Sn5OnriE
         vIj0jihQ162nVppt3T2xDRcZ0dsh+IgqzetwpY4iYv2eZX/jQDrml1iLDVVaXvco46XV
         e8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625400; x=1782230200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggk0IEUcB0t7DeeS8cYHkKKJc4ICub7E45+rBcxQiGA=;
        b=Agsz9WnW27V9Zd82paeHoHCBno79bfLps4V9hdUYjBXPcU6meltm+W6El/9wie4FwV
         uMnjyuO0czY3+LZqmS5kZHrdcOr6XASyhqCX/zBWrCWOLZQcYWD8rHGNTXNVHnQXMTwr
         KB6tFQ2Jd5ZTdh4oXc14wFqvglsYFj+rWDX+rLyk0oosdojZwmk07IUuZfzc57lzUSae
         cjBonfIPZCCQUvuXjv1DnQp0sz/loA29wp7EM9Y84VtGUKGVkS3AioF6ahSSlIsJiHgx
         eSe+KHdrnt2cuLls7ESes3h5DfqNWFruH1dsqSjzJq3/MSqx1wOlbgy4trGphLiNMWTM
         c/JA==
X-Forwarded-Encrypted: i=1; AFNElJ8v8UP0PiPyZEM6Pb1sjKO9TLD06TV5QAERa4rJebJDY1bBqeHPmux+qKQ0W6Q1guxZI/Pmi8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VWFV4rrUBmuyUFRI20kFjqXJeHOOmFUE6QUR54AZq3q/r40H
	s6zwWF+Xd1Kja12R1Puhjm/hfTI6//Qsj4e4sbwX4TrnV7uAdS5qpRqhnzZhtWMpCDRtpQ1CEVF
	5D43j4pXvaTwhr8GQDiLuVWW1DvrentiPT7tjb39d
X-Gm-Gg: Acq92OGJZBNzCeebs887EFzVQbLThFmwdHv5+OalsUgptLL18ICbm2hNrmvVHVorgo7
	c/BLhN8gB2SfmbImm71LkbOmUesgjCPER5y6NBs3A4Z5yJVCjykpLkX6YYRk+HWaF+SUHLB6xa7
	qnEtumgd0Y8+EHlU0dbNClcFZqxj/MyviHEcAgafYuD0vLBpzzK2Wr3pB3hPcuUVYFuftepJJ6w
	GsKEYPl3Aw8DFsWHx/Y6yifkfal2+3b96CDYgcZWNF99ZA5jNye2nDb8FZzzhXNU+P+/JFVuzsG
	xFbAig==
X-Received: by 2002:ac2:5b0a:0:b0:5aa:6c7c:65d4 with SMTP id
 2adb3069b0e04-5ad46fa7795mr23623e87.10.1781625399173; Tue, 16 Jun 2026
 08:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com> <20260506202842.1788682-2-kpberry@google.com>
 <2026061617-flyable-civic-a986@gregkh> <CAMAJAJE+w+vYwcEzkZoNDwoAC3PzJ54sGGr7s+5edBW3JJFKHQ@mail.gmail.com>
 <2026061614-trunks-outcast-6684@gregkh> <CAMAJAJG3Ox-GPz+t05On6F6pJt5rFAvo2AcMW9jJmG1O4EGOLA@mail.gmail.com>
 <2026061640-crunchy-patio-be38@gregkh>
In-Reply-To: <2026061640-crunchy-patio-be38@gregkh>
From: Kevin Berry <kpberry@google.com>
Date: Tue, 16 Jun 2026 11:56:27 -0400
X-Gm-Features: AVVi8Ccvvi5jdMNw15Ph2AdcmkT0fO5wbhhO7X5IAXrT-my8bt4vZMh-F7c9G-4
Message-ID: <CAMAJAJFaFteMuN6ZmJ4iERM8ivYb380tbbScEEn9F3s0JWC8OA@mail.gmail.com>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: xmei5@asu.edu, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, pabeni@redhat.com, rnj@google.com, 
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264345-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:chenglongtang@google.com,m:joneslee@google.com,m:pabeni@redhat.com,m:rnj@google.com,m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kpberry@google.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[asu.edu,gmail.com,google.com,redhat.com,vger.kernel.org,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B75F26919FC

> Please send a patch series that does this to make sure I get it correct.

Done, sent as a new patch series.

Thanks,
-Kevin

