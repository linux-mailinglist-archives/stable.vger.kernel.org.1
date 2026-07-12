Return-Path: <stable+bounces-273454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hk/OIGwLU2o0WQMAu9opvQ
	(envelope-from <stable+bounces-273454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 05:35:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00B743B41
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 05:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=IpvhtGqe;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273454-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273454-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 222653016937
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 03:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84382D7DEF;
	Sun, 12 Jul 2026 03:35:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC5C8EB;
	Sun, 12 Jul 2026 03:34:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783827301; cv=none; b=Xx9fP5zT8BA/JjsD+Vfg7+CCgJNWo9oYIqP9ExTKt6u5pmaXDpB/uGsiCNQ2yRsV8ElLDEpDkjwO9wnxDd/fJl51C2vSqZXe+OK6340MArtur2GdVkWlTHaaDEn60OQacQkQBi0VJpGHnPnInt7zGoldA6H6eVSEHNezhPNM0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783827301; c=relaxed/simple;
	bh=3YyLkfxZWsSQqjyZuj6clz8rVMZcC/tqYo0B/sQQasA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sk/kQVisEi+iDx6FUOdwN8AFLg7gDGEZYusp5MuvKYN9YMF/eX2R71CftOkfnG8p8dG+kOL3LxVsLGZfanU12gjCAe3qxSEt14lLvKyPu2LmridUYjbKfBWlyWAIvsAaw9UX5El5c1+Eb6i7dKs7dPwxwJ6XUJAP+KbSrWJ4Q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IpvhtGqe; arc=none smtp.client-ip=162.62.57.64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783827287; bh=3YyLkfxZWsSQqjyZuj6clz8rVMZcC/tqYo0B/sQQasA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IpvhtGqen6uxdEU5V2hmZyLE5fsUy7Xsq8KLTFNvuSTXWv3mMghynz8xR3baF7nNC
	 3t3LrIt8DHQ+AUrfTCKtzzL9nH1iIBylDjw4OzqvpWQZux0KHXm61HOZWuOqqzDBl3
	 nDjj5wpZvNnkpatm94Zs7KTGA60e9k7Oe/TK3H4U=
Received: from ubuntu.. ([123.52.25.101])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 6D02F814; Sun, 12 Jul 2026 11:27:16 +0800
X-QQ-mid: xmsmtpt1783826836tzcu8ke08
Message-ID: <tencent_E6FC5059F3B82A7A78EA85B8B90D41F8C50A@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7n7pUYDREYkzmrzyPdB7iUukYcJCh/ugzUIDrHamUPa6FGsP1Ii
	 jpaRCXr7Iw9Awgj1UimzCYcL73YNhNhPvwtmYbVemppD0jfMLD8PbprKvnM1/WF8VUCg6i9758gr
	 0cgtGSU1CzbNORUgALomqmD1zdsNXk7tmorsKwK6SXcXomuHvqPLNOjapBCBGoKsCj37ZBjmndBG
	 pdo+QGQntY/3AEmntQzjeX+SWY07JXWhns1XV9k3yqS9k9LQLvmMj1TsgzrtP/L4WqV2ieE4hSAI
	 MuQMrFdmFBhoLhoQA+hXbFyzI4nNd6TG1tfE6D6Amh32lXexVjXfa9esVztx5DGqnrNn+6u0J5xN
	 FVHo72lGZ/1RvJ4ub0kPIqRj9wkO9iR+QggKotz0L8d72kZo6pIn2tCJFGMc8R8vH9s0qmPNacru
	 Vl1c9qQWpYCR1VNYXKWBMeBluzeTF9auJhDf8tzpVuKf4pitgfdYw7HFmfNMrJs6J6tQ/UVI7IT8
	 TeCeZqqlkJuJf5d88WggvoPeGaMHWxL6rzNIzl5T8MItcwkmkyHVSep8HRXPq9ukGDH0fij8tFmh
	 0TTH+AgrmeTdaW9tMYFezNTP3+BmUUELUIlBvwsKh81PNla4Kv4n7owONj7E8W9s/4OM0HOvzZHk
	 FWawe58m1Opl012zJfaJmhUEcj0nJ7ptwRBdDRN/KcErkiNgLehyd+KQAfANaQOW9p3FGQ7T2+9B
	 8stnDe5P7HWJJ8lp59BowXzkTzPdmJRFmhpbuqUiEto3qPRyF2nwlYZV1s9MQ7VZZXD1/3tQBe7A
	 FPxFWF7fMmJOHQgQ4U9AeZXf0+QEXlBVkoPaRPNIHXpX6/bDTvn98mGEDhVlyCJ9iqlPuQJFWYC4
	 sqvFDgzoeZlowSXQ3xFCrxn+8nVeXPtwP402ZgO6GdrEhalCODeFq7ho8BKsqZpGpww6E1boPKI9
	 fNzMoLSXnV+12E5tZek372Vqe5NKaxnP0ssaHMW+62jfJ9prr3oOSmdAaOxbClPI3+tZZtIcdAI+
	 SZZw03HBzwRtxtDNbTCA0mD4oerAeN2zBf7uZkWw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Guanghui Yang <3497809730@qq.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanghui Yang <3497809730@qq.com>
Subject: Re: [PATCH v2] ext4: propagate errors from fast commit range replay
Date: Sun, 12 Jul 2026 03:27:05 +0000
X-OQ-MSGID: <20260712032705.1700150-1-3497809730@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7fdbed91-beb5-41c0-a181-e14a384c05b4@gmx.com>
References: <7fdbed91-beb5-41c0-a181-e14a384c05b4@gmx.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273454-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FORGED_SENDER(0.00)[3497809730@qq.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:quwenruo.btrfs@gmx.com,m:clm@fb.com,m:dsterba@suse.com,m:wqu@suse.com,m:linux-btrfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:3497809730@qq.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[fb.com,suse.com,vger.kernel.org,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[3497809730@qq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:from_mime,qq.com:dkim,qq.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF00B743B41

You are right. This was my mistake.

I accidentally mixed the btrfs v2 Fixes tag into the unrelated ext4
patch while preparing two patches at the same time.

Please disregard the ext4 v2 email entirely. The correct btrfs v2 was
sent separately and is the only patch relevant to the btrfs thread.

Sorry for the confusion.

Guanghui


