Return-Path: <stable+bounces-245121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uENfO96GAWpOcQEAu9opvQ
	(envelope-from <stable+bounces-245121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:35:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14858509509
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3FC63002B29
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463A382F21;
	Mon, 11 May 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bLGRvhGc"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0837CD31
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484951; cv=none; b=lICCUn48A301h5vQIVWUfefdSQ2QygCdlqlXPGSaIxN9rLrLtvNMa/daZ00fjleFUdJh6CW7+HC7Dlp/csmCEyZ2T2C5QNRkY9y607X2O8E7W1sG5cPQBdmX23Fyb1MVpTijzB0Z+j4HKHXMKaPuEyq4APYCMN+mtKcumylf9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484951; c=relaxed/simple;
	bh=d/xXCcsh7w4fDfn0nWrMHR5gx683noiDJkf/Gfv11Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTbOtMYp2GkpkKdAbbQHr9EZvyOpFvrOgX1CQ0A0CEXuwmu/8nFZ/tx0Ro+2jD07UsAbIbQQ7d6IEbW8sovq6wJI79mmWZ7VHYDssLiib6WrJjJTvUsWV7KV2o/M3oRyDgxIVBnTQWAcU5yXTOrsLUim4QodJLmF8sJ1rLPV+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bLGRvhGc; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778484914;
	bh=d/xXCcsh7w4fDfn0nWrMHR5gx683noiDJkf/Gfv11Bc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bLGRvhGcngmGukGRNfouRGpZbXBzLtpbPRTJFvEpGgRUM3aGLZKpWMQWyI2zqUWaw
	 bp3U0DE1ZTuBqq7fNCwKmqF89yX+fqOeBEo8zgcYlxK24h/tpQdCWF/ljIFJVTEy+V
	 IWOep5Y2aeZ/J7om7g0cWT8AYuxer9FCVLiIjy5k=
X-QQ-mid: zesmtpip3t1778484909tfb3f3d0e
X-QQ-Originating-IP: PsKV/sMqy/fnFc3Rf5V4H+jvXFTngHVh+mmQvpVeOyk=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 15:35:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4003599889206080662
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	guanwentao@uniontech.com,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: Re: [PATCH 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Mon, 11 May 2026 15:33:51 +0800
Message-Id: <20260511073351.55658-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051119-family-spiritual-5b2c@gregkh>
References: <2026051119-family-spiritual-5b2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OW4JKxETGMY2qsb1bk5jX+ErrTsJrsyswj04yNzT++gbG7I2wZBOY2GG
	5/t+sJVeiHFDu9beRcpDAUUoCEXgBpY0vF+qCZ42zc7u+zYa1nJIaaSmh7xY72oVTZSVNFO
	aRlRG9TEyPpKtX/jVfALGavp1Rsni9V9YnTFVkd7AfWLnOPW0pnuul0bQAYpdOkNRiqukvn
	ZvyaJUInuh5Z0ksfopznfs+yYyqsu1YGn+jGiwz7zYZnVnTamKyt5R1xLB9lFBqS25qITGQ
	13wSExMOjtrOeiv1HE1+8SBZp2hVDr+8hcxUoINU2PBap0lzHY4qPRzIbihBBq8/+W25Nf9
	N+Lo8ZBUplbDGqfvDUOcUJNaKaYT9uh49w31KyHApYyvviQIIKJEWtvO8M9EuNjGbs///X7
	dZkgx1EGLlLG/I/tS8YihGDiMwPOR2z4J+cp+kEmz40Yo243gbJ0ECU+6WduPo3eWSkUmQ4
	z+1O1wNfUKmhsmVL+bE8kv+Nm6T7cICE8EZ3CS6W6CvX9UHs4P25XWY88XPDbmlYjEInBfX
	JNWeciunxBi3eSM2XT0Ujyku3QDab26C1MfMTrlg7/XV67fOpvrhD6/ZLbGaMnTI4yI64RU
	a3DXrRyseIM627mySIKVsetmuPgmKXWH3r3q52HotVaCSbesuoXpNtOKM8/oTQ3dK3r/zbZ
	B9R4sLFpMFU2MXuVCJGcdo7lbhasE2o0o1UyNKzLN9cvGkf3SF1dZnQRNhCfSxAv8bdHWkx
	J3b6E/NXnCAXqbUynVRrHyCjsi+k3Wk3xT/WGvqHjvH6i7jMcQkAK8jRju4xu0kwiiWg69B
	Bl8z4sEAmastjlDF3RSqpnKRlUUW/DjxsjINQoWILg0p69RH/ldJyxsTkJcJf8MlpvH7RGJ
	nLqWaRhzz6+LfpWFAK0XFro+5WssDgWmwR28CFwZzv9uAd4+bubOs+NTAUtlckjZv6If8KA
	fered6yncoTFfs0tXCNc4LGar4C3SlpM9Z/bmscaB02eOVuVHenP5qxizOD5UJWmwDRvrV5
	iQncZbaqTz9IAKAa2S7n9dzqxetHMVfOoh43+8WBWLsT4TGLwvYsiMkgBUvTj5Fkh4bTLP9
	iI4f/o71Ayv
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 14858509509
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245121-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,uniontech.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:mid,uniontech.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sorry, it is for 6.12.
But miss fixes in https://lore.kernel.org/stable/20260508083142.1752208-1-guanwentao@uniontech.com/,
will cause build failed with no rxrpc_skb_put_response_copy,
which introduced in 1f2740150f904bfa60e4bad74d65add3ccb5e7f8.

BRs
Wentao Guan

