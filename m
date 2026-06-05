Return-Path: <stable+bounces-260782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9SdNA48lI2qzjQEAu9opvQ
	(envelope-from <stable+bounces-260782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:37:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5033864AFC5
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:37:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VYyOOSuM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260782-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260782-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0225B3010C21
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49828438FF2;
	Fri,  5 Jun 2026 19:37:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F84071CA;
	Fri,  5 Jun 2026 19:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688256; cv=none; b=tA8P4uqkwrGNVlPj2GPClG5hTdbdJ0v6fVn5Nu39+AudAvlxWRJX85V6SQap1qq6tNPDgR4C6ljqmRuKB1v2v1Cy5+VCHgScMJsf/01tt2v2FCpBV6fx+UvGhQs4Q01z+kq1YcXizqBiNPWr2i2/vBckmV+J3alnRjFCtIBjjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688256; c=relaxed/simple;
	bh=QAGGheDBMNLmwJKMLh8LQmLR+7oZv2TpMSZySeZEtRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNcPWth/7bRPrlJ5Ov+SQhNdU5bu6KQvIOkA2DyMfe3mlgSgUF7ScDVijnygND1PT+5moePiwaozjh4Frv2GSlpdZ81KopfPjS7vm8Dh2VR8IeryjKEU2nqiu7tb43JhjYU/S+2tLtS9cp4dE4y8MHs5HwkLtazBsdJyieT5OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYyOOSuM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB2D1F00893;
	Fri,  5 Jun 2026 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688254;
	bh=mT5UCczm+tRWl8iiLwuVVtSYGCFek8xY3WuKhnZhn+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYyOOSuMVzsAuVvwhnnau2Y6YMq/0waxI8rfJanzjgyPU0vzAipI2izDnlTomgE4U
	 YaDDRw4/HtJqX5Rye6zdj4nmb71VJPeLOP+TjK69zakDj0oxzBPcg10AAVG0dKT7iz
	 Mwouqad2WWMW5Qy4SKU6DL3WlJgyzxz3u7YxmKK0VUgl5GNYoFjiecdvk48SSgbiwW
	 2DdmtKaGRC4a41viCrs0vGT1PHnWUz8Kqa8hgE0xT/2w9ye4e0YT9BxRHDCOFF/cNK
	 NBuZRCnN96Klsxnv6b+MHOlFdUpNBmBHCRIsVvrxOBQ8nseOMlEXnZdi7fRVRX+LLc
	 vDfUU0TbPsK1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	David Rheinsberg <david@readahead.eu>,
	Johan Hedberg <johan.hedberg@intel.com>,
	lvc-project@linuxtesting.org,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 5.10] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Fri,  5 Jun 2026 15:37:08 -0400
Message-ID: <20260605-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603234343.445-1-vlad102nikolaev@gmail.com>
References: <20260603234343.445-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260782-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:vlad102nikolaev@gmail.com,m:marcel@holtmann.org,m:johan.hedberg@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dh.herrmann@googlemail.com,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luiz.dentz@gmail.com,m:david@readahead.eu,m:johan.hedberg@intel.com,m:lvc-project@linuxtesting.org,m:syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com,m:kuniyu@google.com,m:pmenzel@molgen.mpg.de,m:luiz.von.dentz@intel.com,m:johanhedberg@gmail.com,m:dhherrmann@gmail.com,m:luizdentz@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,holtmann.org,davemloft.net,googlemail.com,vger.kernel.org,readahead.eu,intel.com,linuxtesting.org,syzkaller.appspotmail.com,google.com,molgen.mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,2faa4825e556199361f9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5033864AFC5

> [PATCH 5.10] Bluetooth: hci_core: Fix use-after-free in vhci_flush()

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha

