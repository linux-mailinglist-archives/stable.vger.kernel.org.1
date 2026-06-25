Return-Path: <stable+bounces-268352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NojmN4sOPWrbwQgAu9opvQ
	(envelope-from <stable+bounces-268352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:18:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DA6C50C0
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:18:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=fSk1vHv9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268352-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268352-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDEB5302AD00
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94A3D9DDB;
	Thu, 25 Jun 2026 11:18:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C13D8911;
	Thu, 25 Jun 2026 11:18:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386310; cv=none; b=UiXUCJz1eBSP0m8qXhePk7UpBl3Dpug9XnKf3zKYbouS+fX1EdEl2qs4If3ivjan44Hew4SDTFYELq+Nxpqz9vKz10D4as8wORxOr9MvbNZKiAtugD0oqVLa7mWPG38DpYosyGKnAA3Pa243V62atxAAC6hqA/ys5lEz7GWWbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386310; c=relaxed/simple;
	bh=fAOgoLeAvcBmALqbG3nsGqftPEvzxj+Sk8QuCR3AhFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRIAw8v6vkiiWB5WE2+UjPJkhqM7noaxsv0oxd5wpRudSW4D89lq1PdDASAD0rl1G67GNlrwsXg5yvdVzdm7URdiRBPB1PQJSBxCHbcJBuakNEATQc7yd5YoGSK4UoXOhrNq1toCy0pLzIcPqN/OxQMg9fJE87gOQXdNCYrMm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fSk1vHv9; arc=none smtp.client-ip=101.71.155.101
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43c0dec8c;
	Thu, 25 Jun 2026 19:13:06 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: dakr@kernel.org
Cc: dawei.feng@seu.edu.cn,
	dri-devel@lists.freedesktop.org,
	jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	nouveau@lists.freedesktop.org,
	simona@ffwll.ch,
	stable@vger.kernel.org,
	ttabi@nvidia.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH v2] nouveau/firmware: fix memory leak on BL load failure
Date: Thu, 25 Jun 2026 19:13:08 +0800
Message-Id: <20260625111308.1407104-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DJEQTPJAR8DW.18CJ2FC7YZPA3@kernel.org>
References: <DJEQTPJAR8DW.18CJ2FC7YZPA3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9efe7bca7e03a2kunm68fb4ad27cf8c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh8ZVkhOSkNJHh5MHx9PGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=fSk1vHv9g3pkECkmoJLMWQpP7Xj+htLFoPA1G1aP7jF4T3/oyBYsDZsd8jGPulrd3v9QhMl3Jsw4r6g4mQU+diQ/YXv0tmhKDCQSUPxZExB09QCHnvMnXGzFgzjBXzM9Ysh86D/uhko8GNwKn4JxXMp8f4uxGRkr09uNua4ko+o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Bxv0WhQiYf6pkXwOGd8BAHkpkzQ7RlMAJ6ktjf5RQ60=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268352-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:dawei.feng@seu.edu.cn,m:dri-devel@lists.freedesktop.org,m:jianhao.xu@seu.edu.cn,m:linux-kernel@vger.kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:simona@ffwll.ch,m:stable@vger.kernel.org,m:ttabi@nvidia.com,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 314DA6C50C0

Hi,Danilo,

Thanks for the review.

On Sun, 21 Jun 2026 14:57:56 +0200, Danilo Krummrich wrote:
>> Fixes: 2541626cfb79 ("drm/nouveau/acr: use common falcon HS FW code for ACR FWs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>
>Is Zilin a co-author of the patch?
 
Zilin is the discoverer of this bug. We are in the same research group,
and he actively participated in reviewing this patch. 

Should I set Zilin as Reported-by in the v3 patch?

Best regards,
Dawei Feng

