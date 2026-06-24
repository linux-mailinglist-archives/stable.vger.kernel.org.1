Return-Path: <stable+bounces-268093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wUTeAvSRO2qFZwgAu9opvQ
	(envelope-from <stable+bounces-268093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:14:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 700AF6BC7F4
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:14:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ORKPXT4P;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268093-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268093-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76336303F713
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1933AA4E4;
	Wed, 24 Jun 2026 08:14:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1D3A6F1B
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:14:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288881; cv=none; b=PhNpDUyqni+LhiMUZnEZ0FslE2oS8q+VgbJ6uj1lmQw9r1huVPTZB9qvncJXhUUBJ5oek4/j8rBeO5vmnb31v6KHrft679YE80axt4AOAPp896hCIoNsbpKQgOAvXITsvRBwd3m68zH0G8UBHVjlqfBlMiEXwHlI4W6lYwFoJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288881; c=relaxed/simple;
	bh=SNghCK72DxaazYBg3LIzbKk7npcc3SWRM6RiCnpLKsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CG5ThdTgXPZdwa8aNvd59oMVAucdW1FsR/km2dtFaPz49VhX7JSDfuGFZ2Sa8no9YeQQy8XqxRowy5vw4JAThcO2//PYJLIEnCxygrnwe2Kj0h5bRjkx6D5RX5/XjQmfNuiWiWj4FlegLMvz3INhjn5rI8ZcpLlUWs5uYVUJbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORKPXT4P; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8453bcf7276so544220b3a.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782288880; x=1782893680; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCVBXI/svCRCwrJkBXjKTo/5hLmC+RUS/LaBmkHGSvo=;
        b=ORKPXT4PZmivv+u+YWJqxHv6KUf/KK6kbEJNJ9KIksswf9Z2mVQyihHL4H+aY5SKX/
         sl0yQeMC6qcSUiouwnNU6fzgwOnHcSrW/ZloL8uOjrFUqxWahSWfHur2BTPhjy5XPQ6e
         UWM9PLgfis2AKtF5ijLOer6UtYQYFo8BvlvKYUDxWebUDQZ05mjsLoMQSzg3zxTWotYm
         xsw1Mjv/rlhjoM/Ie1yzdX2+aqakzhksKqtDtpUDMeCM1kxHpcj68WUraOTQxook/nDZ
         PjytF3/8CciZJMDBV8JseqsZo2CoxLxlUCtpIx7B415LOUKsG7hwshPqgRlHiBsdhH4I
         dI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782288880; x=1782893680;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCVBXI/svCRCwrJkBXjKTo/5hLmC+RUS/LaBmkHGSvo=;
        b=bKDHquVWDRkhRe4X8RkCiYNGIQ1pBxtPWc6gY0EfJf+1DONR9QgBu9nAaOyK/r2izi
         +wIWlBSn8Dsy0jxXv5g3/VgFFYmeVKwc3xEPeLkPPjxBc68YvitquyJFspNQcIAjQXlz
         J8SS5d5iaxGV87Mt/bcOOB4fe+rmyMdEdndwgOTxs6hTLRe8S3q/BA4+A7AHcbPV0S3L
         fmsxhAMKjf5rP61itE9vF3T5b84jk6sH6s/uns65foWtrV+9KAHP+8/1wzq3y3j9EeJk
         ElNms2EV847+4+QnrvyCqAEJkNVT75u/fYr7+mC1X8TMYRPPJFD0u2Z6ua5w44sNv1QX
         rcqA==
X-Gm-Message-State: AOJu0Yw23njiJnl/BpKNrgnEBWSB+OAK3rbxPjrYbKaD1bHiGEREtcEQ
	B451FarlZyrAMG1OmhG1L9iZ6Q2eymdir/YJYozM0mJmxOh0rOp8nGnYC6nrNxr9tfg=
X-Gm-Gg: AfdE7ck8urYsfa0iJbqLU+43CmPRIWeYZC/aQnqdyGCvk7ISJF26Dd9ZOJk8oS7cTyJ
	6BhK8E7exJHEDRe+OmqiXCt/i2l1R53IeZcwb7J1WVIR4Yk+93TJ9HaT7XzYW2Nibud57asG7xt
	tMthb+DhOJew3+X4lDje8iG240EJO3Depe+pc38SeE6B7+TLzGXl0KLLX/Mt2GiNbMEoY/BADHB
	0UzrZs05klU69PRp8WPdBYgkqkNs0zxFZ1pie/lF7zROuEyT7tqm1WNx2GW20U/OI/T772535cq
	d57F//2gOmAEcD7NVJX98OFNE5ilbO3/9nFHq5NXAUMgXlQgOziNjEiE0f2A1Vh1Vhnz7g1q+6T
	0iKFet50TTOpjgNNKemwVjac7/hboksVsHdfqQAbh0qcC6aZtAbUgEIlElbeFktwX7LDT4ABUtI
	/uumRVOyVRJGcz7dSL18QZai1ZMMXypk01S/BTKiNDGHzo7dATpJkoJS1KNCD9l81dBA==
X-Received: by 2002:a05:6a00:a13:b0:845:363e:12d7 with SMTP id d2e1a72fcca58-845a2a96261mr2903123b3a.6.1782288879700;
        Wed, 24 Jun 2026 01:14:39 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a41474cfsm1426591b3a.61.2026.06.24.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:14:39 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:14:38 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268093-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[qw3rtyp0@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jwlee2217@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qw3rtyp0@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,DESKTOP-19IMU7U.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 700AF6BC7F4

Hi,

Could the following upstream commits be queued for the active stable
trees?

  commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
  ("ipv6: account for fraggap on the paged allocation path")

  commit eca856950f7cb1a221e02b99d758409f2c5cec42
  ("ipv4: account for fraggap on the paged allocation path")

These fix incorrect fraggap accounting in the paged allocation path.
This can write past skb->end into skb_shared_info when MSG_MORE is 
used together with MSG_SPLICE_PAGES.

Please apply these to 6.1.y, 6.6.y, 6.12.y, 6.18.y, 7.0.y and 7.1.y.

I checked that the IPv6 upstream commit cherry-picks cleanly onto the
following stable branches:

linux-7.0.y
linux-6.18.y
linux-6.12.y
linux-6.6.y
linux-6.1.y

I checked that the IPv4 upstream commit cherry-picks cleanly onto the
following stable branches:

linux-7.0.y
linux-6.18.y

The IPv4 commit needs a small context-only backport for:

linux-6.12.y
linux-6.6.y
linux-6.1.y

Thanks,
Wongi

