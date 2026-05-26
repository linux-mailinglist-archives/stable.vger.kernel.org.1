Return-Path: <stable+bounces-254323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPBGAH6FFWpUWQcAu9opvQ
	(envelope-from <stable+bounces-254323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:35:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B71085D4F29
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D659302AF2B
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420D83E1208;
	Tue, 26 May 2026 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i63HGJA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F103E122D
	for <stable@vger.kernel.org>; Tue, 26 May 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795317; cv=none; b=qr1Blevz68A5M6XmH1QDMAyr3Ws3tsFxHqL9PYmuKipiMN92t8W2ZUo5NkQN3LHAGXbO9xGPVE07WQR3R9FSn+OMCogIdL2YhndDerkjA/VSsLhM/x0uHtNB7X2OLumAYZwTu1K4ApYE6U2hH62LRl2hqPvQ+aI20o/eib0nqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795317; c=relaxed/simple;
	bh=BxdwOR2MarQtDlJ/0bwRTfZMuwhlHSvIAbeAUY3DBVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6bjhdRft2q0BnxlYmbMLAq3MguOFUN+ojFyjYfcxqAuwKe6WUy01crXCxecDuvZNMeGvOqNshWYpB3VWB8DwS4I4tVs0sVO9pq1jrgt7bFXfqCfwC6BoD6cjfJ/2yQupeXL/B6JDmmnwvkSM6lj7kC5arHZOtzLc5LbeYl/wug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i63HGJA+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292E51F000E9;
	Tue, 26 May 2026 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779795315;
	bh=BxdwOR2MarQtDlJ/0bwRTfZMuwhlHSvIAbeAUY3DBVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i63HGJA+BBcUFSgZT7jibErI0QfuwsgZONxhuSEfFwPAMwgrUYSegnw05y0wFkzVF
	 7/1HZ+uf5yCHnWrINAj76UgOeMAT/4aS3Z47MEKddzEwGpf2PpGa1AO5eWsA7RF29V
	 AkG0rA3ndHLtaUmCHhhKQw/YCFrRX0QmoQjQ53XrDk+7TSdeuKqMKxEWXw/RpIP5VT
	 /0bjQ/yjz2RxRlQTpz+Hd6h4fxlfv9aliU6DbLPQRCNbdg9yprX8Gp416EbZ5Xj9TV
	 I+05Ch+xLnX69+4WwbT5D7B4JVCyatYAtUjZI8ckhxbcI1p87/oCFSslI5I/+Y6oCT
	 TrYLVZG7LY0gA==
From: Sasha Levin <sashal@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Jan Ingvoldstad <frettled@gmail.com>,
	stable@vger.kernel.org
Subject: Re: Linux 5.15 bug in vdso_read_cpunode() in segment.h introduced in 2025, commit ac9c408ed19d535289ca59200dd6a44a6a2d6036
Date: Tue, 26 May 2026 07:35:07 -0400
Message-ID: <20260525231000.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524193714.GAahNTaoD92atkAUdQ@fat_crate.local>
References: <CAEffzkxUELNHBzABxVmekE2C_MFuPyfbsvO33MXZy46pNRU7xQ@mail.gmail.com> <CAFULd4Z5vE7v37+4J5MLCttnG=cF0XX+Y_T0p1yeY36dL6i5Kw@mail.gmail.com> <DB2B5B4C-200F-4C0C-B14F-F58E0CF4078F@alien8.de> <F51A475F-F50A-4DE2-A098-871047496301@alien8.de> <2026052230-obtrusive-prowler-86c2@gregkh> <20260524020311.GCahJcXxBMmgUUaWNv@fat_crate.local> <20260524150046.agent5-0001@kernel.org> <20260524193714.GAahNTaoD92atkAUdQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254323-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B71085D4F29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > Should I pull it from 6.1/6.6/6.12 as well, or only the older trees?
>
> Well, that patch is not really stable material at all - it is just
> a cleanup. And 118c40b7b503 ("kbuild: require gcc-8 and binutils-2.30")
> got added only around 6.15ish so the 6.x ones should be affected too.

Reverted from 6.12/6.6/6.1, thanks.

--
Thanks,
Sasha

