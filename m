Return-Path: <stable+bounces-245061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA8cHNbDAGqJMQEAu9opvQ
	(envelope-from <stable+bounces-245061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:43:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1575057AC
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 056603001A55
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8983365A0F;
	Sun, 10 May 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fbk68tRS"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C433ACF18
	for <stable@vger.kernel.org>; Sun, 10 May 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778435024; cv=none; b=kL2DtgytY3ZfoBxITkedIJA/ZlCEuz8z7WNSfuQvt1l0xsB9xDnTYvmSdXaxPtbPmAXE6VAFx95/v377uPuK+/+kOgPgb/6Qnn/fF4cPSnm9jtYI1TItXBsvbZafBHBaHhoj0+85g8r5jUTmuQ2bX0XarjALZUCavsreoigeg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778435024; c=relaxed/simple;
	bh=WaTrtWBgxI+HwXGR2mdP1ixFOGVs1h2Oe+2uFnauaKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3fdI44h1hBBmX5AqdTN5y/SmskPuuW/Yo0VA/2s6i88bBLIk2ecbhNAfazvZLc++ZRdjXdB9JJaeOES+fAB5MvcEjafyOoH97zbYSoFRAT06+1by2KYoF4e13CGjR3eLeIwdUYOzRH3h6A+0oKdgrNSsWJTKpXuSHVCMyhRx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fbk68tRS; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778434945;
	bh=WaTrtWBgxI+HwXGR2mdP1ixFOGVs1h2Oe+2uFnauaKc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=fbk68tRSuXQq5fLdOB5//ZeE0ATRtLTtpPqjNF+W8Lbn31B2QfdY0xY21mkPuKmPZ
	 Tztbpj9atVwE5a6uBHLs/2XOSD7OCxNMTBN4uSInHic4+tGEXzPdulZCG5v+PmcaB4
	 QnqEvdYw+G+3ZzyQgMpmwttYidpTZAsDvTcIKDf4=
X-QQ-mid: zesmtpip3t1778434939t2bfe8359
X-QQ-Originating-IP: VxYeqzK72NWRoA0gIf5FQvh34OnGXuJOHcYlcUcCd4M=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 01:42:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13886034995667145032
EX-QQ-RecipientCnt: 11
From: Wentao Guan <guanwentao@uniontech.com>
To: jaltman@auristor.com
Cc: dhowells@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	sashal@kernel.org,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: Re: Backport RXRPC for 6.1.y from 6.2
Date: Mon, 11 May 2026 01:41:02 +0800
Message-Id: <20260510174102.264374-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ab79de29-afc4-43b2-b12b-9c0bef976aa1@auristor.com>
References: <ab79de29-afc4-43b2-b12b-9c0bef976aa1@auristor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MJwQnWntXQ1vkY8ml0ua0aaef1sF6Qi/BLP/eDPHAdtGNTy40KAKajUq
	lUZCkW0GVctodpfIG/BjXcskFlWfkg9/0u+rz44zABluZTqU0JsEYy9KRQT7y11Gk0/CKvR
	NaCm4K18fCCZl4cItMcqr0wR/2OhPGFM5VV0q075CPV9PvgxAEBZb5s8DD/RnU1HgMZBKhn
	Wlobts77wuPJDxktjcoGE4LSvnIS44IR809KURxlCCJKJSvRsV6ueJ2fzscpM+3ZJTMir9Y
	o9rxN3rP1WFY5c4IH1xS7mft3YudF0vmVO8ULJ2oPeyzW13GMj8qeR2gR0z8DizdVizSIta
	UHZsUIPY7ybNN75YYCXkXCHG+rSmS0bHYP+7ewAb7UBG57q9JFU3TANQUzAB1uB0cQfkMfv
	aYsOfZj3VeuRH99akEX4MEUv8btubi5mIctS44K2O0hBQxTxcTAP3mNpmFcaijmOAeMUy7T
	9W4p8Mh0zEF3GlVCitofhDeiyMVLSCLgerGkNlH42m3P12HqclUR/VSGjCwCWvwQQfiVDj+
	LjqWd44mq5DSFUcq6CrsLUkpa74teieqQe5c819dW0vsWeF+ZjW6wURbvDt59p41FKtlY14
	Pc++MB7t9woJnY6dT3Xhzwbbt+Fy7cUrTXGjWVm77CVJRssFXXe0xqjHg0Sui/4kbFgryyW
	7wqdXgucfaYfujnFrFLv8IKOFj/KqsOge7LR6MFn4AsE00b+stwbI57tXhWXAogWkKFi7Tw
	b5lwx1iI8h7v/CNnUnBOAmkv435+hAckn4D0cyUeri7Tt7b4fMCWxIOJ3bPPdkYHTgdzSox
	RoQvm8PuSSoCLJyjDwQoKUelngWu3j0RTTD7qoSp9QDLx49HMBepHAA1uF2EHrR9hXORQVc
	L8bHPF5T0K+JDydOFye/dzZlvwO8CjUZNwy8ZlEpfXqeMM7Rtf4VKNyfQj/w/mjCfdS35pB
	kBXXjEFO+E5HGM0MPes1EZvFcyCtNL/arxATxmjAn5tILTJy/YOgt/ULxhEJtw1RoG25IqI
	b1epLnrofyNrvtIMMfhcM/lhp/ln/kzVOKjWazYaAlgEUPj5SM
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 4C1575057AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245061-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

> Are you associated with a Linux distribution which ships 6.1.y stable?
We shiped 6.1 kernel past, and we are preparing the fix for it.

BRs
Wentao Guan

