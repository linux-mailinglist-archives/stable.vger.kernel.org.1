Return-Path: <stable+bounces-213249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBZlL2sEgmmYNgMAu9opvQ
	(envelope-from <stable+bounces-213249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:21:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A319DA7DC
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5E330A6E16
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B03A8FEC;
	Tue,  3 Feb 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CtxrHnbf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE33A7F79
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128321; cv=none; b=HahvcnYHSv72LI3BOG0C84bCf98NqrO86FwhnCeFM7StRB671mnt7f+nsq8uE6Cso6qhY8zjRDnTyuQg6LaMQng0Kx34dQL96T6zEQDvMvbweWxsSiR2Hx6RROTUmOiWET9eCFkuuKydtrdQxQoaQkTtuocgwB8OOxf74npdTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128321; c=relaxed/simple;
	bh=KvCDqA65KrBX+CwTto3JC6CfMq5lUMnkIhoy59YRSb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qWrQopxKgW2rQHRB9qso/dGSKvPN7Zn6m+L2/TI/gj4AEhyKP/Yqt1TM9KwSjTRHwSpOto032fA8TBFbXajF57mygoGmEAesTgr9rxm+fe9dE4vkPUaEGw1wqX9NFnysSPJIhtnboQ6pgzPkME4JI1nIV/byU0Q3U5SWUpl/eu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CtxrHnbf; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-460f3f9fdb1so586420b6e.0
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 06:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770128316; x=1770733116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwcVV6buKbnV8b0sHH6/zSD7Dj84b+Ds/+4SC8Xo5MQ=;
        b=CtxrHnbfkukZGG+4LAitDmEeElzs2qDQonSSXkB+BhPmVBMz55RdFxAkCk7u9AnNmQ
         Z4l76aQQYyA9/RzUNympJaPKXBw5Ih8I7vN/IFtqFA+vcJdiogwd9x3X6FzO0JP7vN+G
         KBccWmgILdVIYtinUBLwXNAiQoaoV8tcAY2/BW6qvJCOBId7JnzxcW7D65dBpKXhMQLO
         LFaerT//fu56k8oTBbhn/jGp5SIdBn1+oqcp/VuJZiDHTlq1d2K4gRVzbNokm9/BkC/A
         Dhk2h1hwlMq+8xYQooQ1RIuiaXbZOGfQvEjvj/pbKuiGkaDHHnSq853fZhjDxeXtDIBP
         yPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128316; x=1770733116;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JwcVV6buKbnV8b0sHH6/zSD7Dj84b+Ds/+4SC8Xo5MQ=;
        b=LSOTfCYvtbSPW3qYBx6vA94v3qDWrzQItfCgoYRz7FN+1JLs3BqbRIXhbKeyPkxEou
         EnoerRYv4pIJSuPRty/ALQS2N+AxjgYkFOG1b4YiuEr+oMVi1hCxBh2WijsfA7fQ/o6O
         ffu7F7Slw/vUztEuWsGpUYMbr6UwiIPJIgAW1/N+5t1BoXp8jd/4bGd4KHnEIJFxT2gl
         CoNFPY101lfzRshyLnzDPh47WkkTiYns6tXNHJlaF+bqBXMP5mYOjvfqngoD63kxWT8R
         zSkajoCWscVC1s+SN4H1zibTeBuizLUHmE+9Et5QR+LvpiwlGZ52RSWz2Xfq3xkvOR5T
         vGUA==
X-Gm-Message-State: AOJu0YxWnXTdgyJKUlovsBM7S8f2KkYgLLMHvFhhWF2svZEfXZzD4dQz
	Xj6daEyQO3fru5XQSd8cWc8TCWA/j3jSKiC+VVxWYtxpS76Oslr3np4Tu1QL4Zq3kZA=
X-Gm-Gg: AZuq6aL4s1fjPkiEg4Bozp51IPBRjT0C3pzEiZ13hHXMRduC/4nKbR1nNvV1ru0Ov+x
	L8sHmvQPqdHgumpVZlOb+doBViPJvCEHLND/ypQzeJO4QuJ+9IPkeiquZQo5TvzZqz5vvLmft/i
	wXhMWpnnUHykhtudjyH1PvTOgBIpw88332xzXdwxgtTG2OJSwcr0JJPP7cAAWr4zITx9qRmNFmO
	krMmBwGH2OP4PVJFuYflJUI0P9Ir0b4prSn5nMTxfAd2pDXsb5Wo5hbWApHtppHViFjOjhansfd
	2MvTM6EnUbB5nBzd/PnJHGu11NhHsImxgnpiqJvXdtCCAzmGNCfcZ2vVKhvkL/1JaB43uhZkbY4
	v55qTG0WHJXhU19ImJM9kur7A4scZKqilNxg/w4TT5f89R3T+8sfZKP2hqmyc36klm19qaQm6ZL
	pyVElbpXuBY7CNSj6dwKazxwbM2bi6DljCfA4zAlTJNtNj1QekaXXLb0y6wa03YVSd
X-Received: by 2002:a05:6808:c40f:b0:45f:103c:2483 with SMTP id 5614622812f47-462c1257df0mr1329964b6e.23.1770128316350;
        Tue, 03 Feb 2026 06:18:36 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462cb7ca939sm611916b6e.9.2026.02.03.06.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:18:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>, 
 coregee2000@gmail.com
In-Reply-To: <20260203141239.73274-1-ming.lei@redhat.com>
References: <20260203141239.73274-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: fix UAF in __blkcg_rstat_flush()
Message-Id: <177012831529.1184270.8914986281572027471.b4-ty@kernel.dk>
Date: Tue, 03 Feb 2026 07:18:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-213249-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3A319DA7DC
X-Rspamd-Action: no action


On Tue, 03 Feb 2026 22:12:39 +0800, Ming Lei wrote:
> When multiple blkgs in the same blkcg are released concurrently,
> a use-after-free can occur. The race happens when one blkg's
> __blkcg_rstat_flush() removes another blkg's iostat entries via
> llist_del_all(). The second blkg sees an empty list and proceeds
> to free itself while the first is still iterating over its entries.
> 
> Fix by deferring blkg_free() via an additional call_rcu(). The second
> RCU grace period ensures any concurrent flush holding rcu_read_lock()
> has completed before the blkg memory is freed.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix UAF in __blkcg_rstat_flush()
      commit: 7ebd605ed5adf7ef688e15295cc8cb18c92bf572

Best regards,
-- 
Jens Axboe




