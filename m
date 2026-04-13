Return-Path: <stable+bounces-235902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG0qB9pv3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9A3E742D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D47E43018C3A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D2384223;
	Mon, 13 Apr 2026 04:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRS1DAfh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9153822B3
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053647; cv=none; b=KRUhVJN45CneLdGUMgHJoav09S41lRwTa5WNf5AStdI7Y+1+C+RntYZ2ERkx1FKo5CFP6hdNriNBSYUkGQk7GG+GqD951JSal+b6aC4wqBkzprOT7fIrGCQ0vuuI5XCuuer8AdT9oesajrFBpWEwdKe0xfGwkzC69RqZFLyjF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053647; c=relaxed/simple;
	bh=RNRVJrYmqG5YlmX8NduMldnF09efBUPi4P4Sq07qN7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9kO3unZChWe3Cwc0w5IefqMff1MQgqJLwEmNHbtSYBFRhRiAKBVxCKiBce/yZnRndY54Z6mrXDtGxTU33RwspDwcBUbr1glH5vqf8WFbmHbka5Ll0XXpleiOStr2pEtXuhPBdGa1YdIHAiu3mLes0AAfWiiBpKF+7t6yBHyir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRS1DAfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E39C116C6;
	Mon, 13 Apr 2026 04:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053647;
	bh=RNRVJrYmqG5YlmX8NduMldnF09efBUPi4P4Sq07qN7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRS1DAfhK0w54dukoq1pAC5K9z2Tq0lEhxQC398QRddk7gYUDwzQtpFwVvg2VQeie
	 /KWsyTWoNvHw0Snubu2bnqPhP3WmWJfufJ2EZDq0M1xblCkvyfDlYzEdNc5kAnBwoJ
	 1i1XPjCZdb0CL04gt4bdNnkRc6lTJHPORD+P3Db1XRvJ85od2S6jtiMEHi5lO1Us4Y
	 IncHTpWChmIvfJDdc7SYy3SIsLSlWik74QZVrl0JE60hv2+luyIKGKGSThLexBzORI
	 NGc7DGI6Ta/BdBiVOp5kAZgue50SQQqrIFX7CStuPkKAYXBtaV4IbBniQJOI9BVAv3
	 z+4+SgIUrAuBw==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.15.y] block: fix resource leak in blk_register_queue() error path
Date: Mon, 13 Apr 2026 00:14:05 -0400
Message-ID: <20260412120103.block-blk-register-queue@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409063616.117503-1-rob_garcia@163.com>
References: <20260409063616.117503-1-rob_garcia@163.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235902-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECB9A3E742D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 5.15.y] block: fix resource leak in blk_register_queue()
> error path

This patch places blk_mq_sysfs_unregister(q) on the success path (after
kobject_uevent, before 'ret = 0') rather than on the error path.  As written,
this would unregister sysfs on every successful blk_register_queue() call,
breaking block device initialization.

