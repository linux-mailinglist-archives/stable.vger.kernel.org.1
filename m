Return-Path: <stable+bounces-213079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Lv6ErbQgGlBBwMAu9opvQ
	(envelope-from <stable+bounces-213079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:28:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE43BCEF79
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B0133041996
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538A36D503;
	Mon,  2 Feb 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdhhbmEP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A528134C
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049385; cv=none; b=OGzFrp2pLaSmDKKKMpO6+OoR2ylwj1TXOoTPssPrMTNtFj8IihK1L1ozgvBNJ3+6UlETHOo3bS7Xyicre9s7oFdTxW6EDSSpH92zN6fBhUWPhyNKg+P5iCWg7xDHNDmAdBhlaP7+boMS+htV1O+y35Ri/sHtYfCyl2TfnxzmDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049385; c=relaxed/simple;
	bh=tDhcTjNxU+xemZl5KpnqLTDnF7wvr6XCIXBv9yqxToI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkE+rm89fkeI8ztPj6ut9oMB3vorfiHr453XXjR/UCzzoWnzG3iLZ8uX9lTQ8gVGEU4WQwfyp2Lw4OAbJpiApsds+zjvs7YJDx880v7j/kxZWREPLgglr2KMPIqjoy1Qeb+WKdYe19X3gE3NignQQfYmO/fFUjjIVdu56rJEWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdhhbmEP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc305552so4342687f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770049383; x=1770654183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYWBbcJbimtg2GEdnq9nutfbY+5nFxABvl27nUuJuWI=;
        b=QdhhbmEPzZz7TSuGedS6jyuHGmlIDKMfxwsDcNcBayqPCeYyTiwHmj2nxXgjgERhLg
         O2HXd7pP0zCihlrGzbjdYVxpmsxlT1BAxzTEAp5fhZi5As3n4DH76r/RnbDmYauDfo/g
         eAKM+LDmIQ0l2U0bDIwOvM4QUPe69nEFbsjC9vUSXIcN0x6YK/p1C6j610gqK0s4cgtx
         cFZ5aWwI5vF0mZWHIW6x70OVCcwoQsmWG8s8WbuZda7jRtca/LYbd9mb1Dfk+ekc4v8p
         cEIhIFR4qYnGpyaaUEFzlxPii+4TyeHDOp+aVIlfb7SNqSolV7GMInRu5W4I5305aiCO
         BKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049383; x=1770654183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iYWBbcJbimtg2GEdnq9nutfbY+5nFxABvl27nUuJuWI=;
        b=Lc3c5cLMlXfyAFmaT/sNXyrUfHQXbMAY4xDwJJlw4vurz+k/CEQlwrMoDrdOg+hmDV
         cqLKkPRmEK3zq54vQQ3ngIMnAtOHsOQeQiZL5G3bydpG7FtDMaTYNGNW0fKYob4Zm4qV
         7D00aPRffWlw+EiWL3cp0k5l/jaPMqrJ7eP6+DdrIVUCyqk1j84upLASQPo7bZ0zy26z
         xBKtfQw426rBxseK5OteQ7YyjfOUVsiRCrD/LvrxcRkH2INJbv3eL/K7ZUIPBSxq/OCg
         d1olw5wDgdaJqo4AWqiygooRoTs6MlTP5Zjzu/JEG9eP7/zs8NuHL/wzfx4SWqNwTqub
         gGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/zgi3yLBhpl/4rrbnTuPEaggw+PuhqINdHIyLSuwDxubBgonoEkBiNgxOJ/jeMB15vx/VoRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw833gooKJ8CKQ4iAH75TxuxCPujlL7gGWCvEP0YKX68PwfNdbx
	QaifUN0P/rlJBz4Bj2pHP3+KIuDOlXft3bvzoGEY+j5WZDryPrhOa00U
X-Gm-Gg: AZuq6aLqBvVK14bzt8SETve1Lvvc3Z7xrC0SmIo60sDwPmTCItpFhlzEMnqlhfSSiNf
	hhogYiKpLLXqeoVcyD3TGFyEtGHtNsspchbOUga8I4NKXGe5eMv852oJN7lFG9hfxJRZsREi5bx
	pKailgfCNdZszHkCJp/YbP+lR2+mZfB/xnDKYtJpt2n7VAPN3iBzUiITja0OfYwWOT94wE3/jl1
	j9HVgIs+t6LaQKBEss6nIp9RzrV3X/a6wLgUkWK3B8pRcsZ3uYvOLYb/0Gqsqtp+I6I2gwjDW5g
	Ms7vUzFpXPqplcUEkTi4gCo4R0AyFps7/Sxvs5zKf3HCiqLYYtov+GIvYpnzTawwW/j8r6l0Mhd
	qRZagbru1/MQbcFgykVw0n2EGM1vjoUQIIEjO/f0UA7RzKDndEgTCyNr1J5R+kjB2pO0I6Tda+J
	96XPf+4vA=
X-Received: by 2002:a05:6000:2404:b0:431:9b2:61c4 with SMTP id ffacd0b85a97d-435f3aafe61mr16769082f8f.45.1770049382376;
        Mon, 02 Feb 2026 08:23:02 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435e131cefdsm45989708f8f.23.2026.02.02.08.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 08:23:01 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	lennart@poettering.net,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
Date: Mon,  2 Feb 2026 19:22:57 +0300
Message-ID: <20260202162257.2384773-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213079-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,toxicpanda.com,poettering.net,vger.kernel.org,zeniv.linux.org.uk,in.waw.pl];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE43BCEF79
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> Add a immutable
> rootfs called "nullfs"

Why not fix pivot_root instead?

I. e. why not make sure pivot_root will work on true root of VFS?

-- 
Askar Safin

