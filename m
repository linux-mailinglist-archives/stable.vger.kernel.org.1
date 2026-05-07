Return-Path: <stable+bounces-244474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNzBKtve+2l4GAAAu9opvQ
	(envelope-from <stable+bounces-244474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:37:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D6D4E1BB9
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB9BD302084F
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 00:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9491F91E3;
	Thu,  7 May 2026 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiCEmZVP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D41A3157
	for <stable@vger.kernel.org>; Thu,  7 May 2026 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114259; cv=none; b=C+HSgqVVPA4N6eJulPRGR2tcyt1gWCjbJ+YA2vNINEll0QwWyQhBXiUcintRY29nFCtZ+PKI81m+O5U3hPH4MBOdOy1hKfEYxWoCHlQ2M/orp5WVnIvSL0WrHk8G/DfgSO5PFKezyO1SVPZtinu68Ac84fI0W4zngbwCwgKwSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114259; c=relaxed/simple;
	bh=fz6l9Z4iYUBHhumWdhqUenv3nJ8+M9OXu3z4lbN8dSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aj5Y5pTY1eqrd4DbL1WuLcMz5xH3P3YNgt6a0c6b9fv/8kGAKAR/kVU8NSyT4tWZL+RnAMVPyjUEPrrMUW413JueUaV/cqsrSYRx0vZHqVwVworlUkf2r4FaJGxadMAFwnlmCxbCq/JFYUb67BYzjmhBR8skkM9+Ak8qs91RKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiCEmZVP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ef5776530bso34536885a.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 17:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778114253; x=1778719053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz6l9Z4iYUBHhumWdhqUenv3nJ8+M9OXu3z4lbN8dSg=;
        b=jiCEmZVPtX+XF2VCHK6x/VcjZzjRnpN0JUsx/w3ZU9fnOBeVdwCopMgghrRspbi7Sy
         qa1joh45CcbLN29XBw6s48S1I1lrmmMKjggvPDK0f1IMgOYoKUcVCOTYka9oBUukNolf
         0pZ8a8+jCTh6zvMnc/GVPrmdilHlfu+lCzmEH/pe9qhbcbykobupLWUnR7TVtInewn1e
         j169rorW1GUOeA+TKKZ5VVyEb3TCfyr3YQZnVLu7JYU7WbssCO3AT5pMcb1852zeE1Cd
         7PhnhUA/jJK6sUR/9oRuDt2tjvCmnrCS5GqsmTfb09Sl11pdLDYu+pTdpZnJIYASCJ5/
         fiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114253; x=1778719053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fz6l9Z4iYUBHhumWdhqUenv3nJ8+M9OXu3z4lbN8dSg=;
        b=qgpW7Sfm9VRbDa6Fipeaj6xmqfb3Llky0BxE++eu3vTqr9XQNcQU2zSQRoY+D6bMil
         XJIQwT8zU6FqEOFTP4g2RGnBLgzmH+7xwlUkb8VurCpaGC6UuCPSrKQq81TLOUjT5Tku
         FuBFLadZMo5be1SaWXrhZYCjocgroZbx1IbXN+POjqhNTDJBK1TtHg7KjKa+lXWXbHoF
         VmfXdJ1zBoV7K3w00gaiO2dS8Ubx8k+Jc6f3NoUHpJ4X1R78ghu2RfSvt8ab2p1Jkig7
         BksyzptI5yv2pGW3p7AMGwgdLciluP6DPFFGxwgl4M2qD2qDceiyUZ5qLoNnptfq8BTk
         BD0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9NadbzzeA5CWqfd9/PrOvYreaoSDSlmFgwlHjsVEE/3LuDzlh7aTjaUTqUzvJA6DwEHGzs4Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23kzwkmMLj+q9RbwelUe96rY7BS/sNhefFIFyEU5lXx/UvAqm
	Wo2juN2F3RZzHPjKJ9pjP4auZ/dPuSt7ITZ8LW9mJi9+3v9XZayUdGpl
X-Gm-Gg: AeBDietVsF2my6KSJaXOxgpKMa0E1l1lRBHsVXdrg4EMkBz6Eg+TSzZxM9GpP90GODq
	jTYvDpteH49iifTvXiesQpDBO7yew5IF01iakqoXdt7I1gfLEbHcwX/m8zCGmyIge0+X5OK2mw9
	U7yv2WQ46DJrrVeZiNz9kBchgWieRW4CUHM+16gNcBmWBsfmyhxrrit6Om0GmMI3XBsBWDvgsih
	6LCldo0nPG9XB6tJqt572+E6wRcrEi36GuT16MZbJwQJXZ9XT2vcMwBcERcbDpXsuPqrKK6bZ38
	SQcoj/+qPiedSYbpj16TIOdedWQkX8BqlBOVArjamT9LaCXPxWKqmd6yKqD/oiUthfm4gMgRnqz
	VGohG2ObCmJoJs0yTHDLmEOk+dp4BXzIXA2vZYuPXesfHvFds3QQw9PUR/UU/yDAyiY9/Ga/Gza
	qQxUAWRwEWCYREzzc3xJktEkqDuOQDnXD9t7F2UiHpZHjn3bIh9nM0+aeC/lzO9eD3dv25g+LzP
	IJaSV0JLlVtsULGz1/9IMzUZDR6Y4LVIhV/PSw=
X-Received: by 2002:a05:620a:179e:b0:8eb:6f04:f97f with SMTP id af79cd13be357-904d65e0a4cmr874756085a.44.1778114253357;
        Wed, 06 May 2026 17:37:33 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c25324esm2051748285a.23.2026.05.06.17.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 17:37:32 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	lyude@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers
Date: Thu,  7 May 2026 00:37:22 +0000
Message-Id: <20260507003722.986428-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410040026.2436280-1-ashutoshdesai993@gmail.com>
References: <20260410040026.2436280-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30D6D4E1BB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244474-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lists.freedesktop.org,vger.kernel.org,redhat.com,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

Just a gentle ping on this patch from a few weeks ago - no rush at all.

https://lore.kernel.org/dri-devel/20260410040026.2436280-1-ashutoshdesai993@gmail.com/

Happy to revise anything if needed. Thanks!

Ashutosh

