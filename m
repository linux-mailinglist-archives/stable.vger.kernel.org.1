Return-Path: <stable+bounces-268089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7xczBJiPO2r/ZggAu9opvQ
	(envelope-from <stable+bounces-268089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:04:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7206BC67E
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:04:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="TRWWoEw/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268089-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268089-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F07373006165
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC938E8A6;
	Wed, 24 Jun 2026 08:04:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E9385D69
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:04:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288276; cv=none; b=OuC/z9Nqh5MAN8xRo1+PREcinE9tUTFTFRupJVuv2xRCX8Cw1rqkhmC8RiamFOeuQBbzcId5qkbc8Pgky8nM38eLSvdz6x13ztX6iwEIuOQO9gludO4PK65zqgzjF/fKILXeSiuDuIUzRkomoC8dFWAdJKv1DQjpgwqpGmlh9ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288276; c=relaxed/simple;
	bh=z0alSbmaJJWcA52g7/M1v2TN0Rv1w27NXV05Q0CgH8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTOm2R0EFOoeMIdRKMcRLTokwJMjQ2u11/nlE43ORSJdzn3o7kyZLVp0Mg+GIzQJUaX82VdPVqMr1yliSDR2L/QwYKi/xaZHtP8WzJY9iC+OYF+35inFkM0l3Y156pdV9ErsaTdHs5Jm65NQWB2NNGyzemUyfgTSHs9Nih/g3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TRWWoEw/; arc=none smtp.client-ip=18.194.254.142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782288196;
	bh=oyTCBFYG5IAdfwE4ZxaVrnJ4/VM+a5SBJWOHsTLTxtA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TRWWoEw/eb0FmpcfYl3X06ZHkwn3TSNfRkZp4sUCE8nsqKao284l0bGGqcJ7TcA/s
	 t+6s/2Ado11/HIdzZvCqkUc5wTlO35bhSK8I5C6gtCE0PcXTOaSsrMHWGlj848k7Nm
	 tYxq6563dXigNMjuAcT3j/lkkBg7GRaCEmQjoI2s=
X-QQ-mid: esmtpgz12t1782288193teabd5a58
X-QQ-Originating-IP: WaZyHcVvJRB1n7n/2DKbQ74NJKPnAMc/EFQ3L+s14+s=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 16:03:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11382400478677146413
From: Wentao Guan <guanwentao@uniontech.com>
To: iklatzco@gmail.com,
	gregkh@linuxfoundation.org
Cc: 00107082@163.com,
	patches@lists.linux.dev,
	peterz@infradead.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	yeoreum.yun@arm.com
Subject: Re: perf: Fix dangling cgroup pointer in cpuctx
Date: Wed, 24 Jun 2026 16:03:10 +0800
Message-Id: <20260624080310.2502480-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616145120.525872058@linuxfoundation.org>
References: <20260616145120.525872058@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M47yMtM9UvTazSrR+mRSIzgjWUhnL+YgGndaRoS68Dy8dMVr1aOOjlhs
	HmBDaCm6SoBc2baYOj5YwueNbpuVxZCeP9NfiQfIsHho/yUhEaAKz0txUYKutEiiW876u+D
	9JHsNnOzsOkDG/yyt91Awig7pdYibu0hcQ9jGtL2USCvJRcfHcJuUxoxR5sOALNDc+6+fMs
	qjhVbO4MDZJ10eR4x28vSrCuwJ+kvm1YlzkK5IHdyAtwgjU30FrkW7OjCFDMusTnBLNGMRB
	LQhrl/7uJYTNittHW6xiieOueLFq6DgU8CbT0rWP4CjzdCn7w5E1LXVcIx5HHzpofw1nKbs
	CVhb5NcLaKayGmn89uy8VgKqV5p0T0807pbJWWn3NJDpIaUaPX/xrtpqKHzRT+4nxeEA2PK
	mTWSzO9vFBY2eGc4mzJZyYVXklaBhaydixTDX5NLYyyFet4id3x+a2SVeG6U8nRU0uQqoEO
	RX1fT2AIfDMwGlaDFwVAa0Py4OuvZDLu5IZRwW9FILy1f/zrys3ELiWUG22m0EPquH5kFIY
	4phDKWqgII5b8vAaPsuQ/wi+Cn2PVUckETYOtVNizHgkhdELrKHkCknD9xPTeEwG93Bf9Gx
	CGkn9lK0RJh9ELRgKBwgxtejM9EK5qg9CTgpzHNy1Ubvd2Nu5epfFsX6LQp3+N3GXyJuydy
	xb5LWUfadUER2pt1mvWvJBObykglMBBZ8U2KFhYjLYQ8vc1/LY/cU69Rbg96O/eLohdlezV
	Ka65A/YOCOZ2YC5iASvYE5U7BH9nrWhXGWsRlBeKJCPDy0cEqUX9zT3tVeNgDE4nS1rzzne
	+dhmV+JnIFg7rZsMBulFvxlBJglSTEUEuFo7RRUTQxilbs4BaobZLoUypJQS98DYhF1w4wn
	y9cG5AhrmsXaj6cUsbQx5AfjZ+KD0ctESfLtVI66rDG09NMGihrfadQ5jLRThQxtwbUpHBJ
	RyLB5K8wmuf14+OOLJeL6W9AFZ5ucSvA0MzIo6QSttL3rPZFbALj3XsrbjH+U1JdaZLUxxT
	wWKzJFs9PKoSrhAQCp
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[163.com,lists.linux.dev,infradead.org,kernel.org,vger.kernel.org,arm.com];
	TAGGED_FROM(0.00)[bounces-268089-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:iklatzco@gmail.com,m:gregkh@linuxfoundation.org,m:00107082@163.com,m:patches@lists.linux.dev,m:peterz@infradead.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E7206BC67E

Hello, 

I noticed your backport missed - 'event->pending_disable = 1;',
which different than upstream version, is that true?

BRs
Wentao Guan

