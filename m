Return-Path: <stable+bounces-223327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EL3LO25qmmiVwEAu9opvQ
	(envelope-from <stable+bounces-223327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 12:26:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FB821FA1B
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 12:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D01413041BF4
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86E437CD25;
	Fri,  6 Mar 2026 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fxRsu4eN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5C37474C
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796365; cv=none; b=LX8uYLb+d+eg3ntLEtrRGj5eUqYNDlcLzQ4ZCnhknciYr/6anjiuKgPc9OTasdYyiwFoPWUfaj2Hup7IixotOwSja3ZyVSwjfEsYHIJY07+iTIz7mfYYz5RGy5gWwSD410Mpov1A/IHgASU4ubilhzazZbOUuvzozSDBUQKa3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796365; c=relaxed/simple;
	bh=jAGSKj1ZsgiqwMByh0L+FjCY51vEgZrFGEp0Xvl+V78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A/DnXQGHaN7Lvn9tptEr73bcQ9NlQDYgghjF3wauDHccSJwyrxxhP5tYFSj1VaxZtjYzE6DLYPlLgbe3hFmXYQySDJZjejv04ylRmJixk/bVl+0AQx6FrjdC7CBZydisEUpElkENDufVEI1FkuvBSnrDMhvN5ebqM02reNG/mZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fxRsu4eN; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so8858080d50.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 03:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772796363; x=1773401163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CY5l8ywo2gfwV8s6iTms1Cd6/EkzG/nG2cleNFaj6AE=;
        b=fxRsu4eNGypRs0WamIJoEq5Pjj5DD1rfqULA8/qZugTdoAi9SDe9JnZIXIGGhALWjO
         0U4jJ/ZNcq+FLUkU6QFR3rop6vgZReg+mGvqNFSAiyxlQ5GYEPGA4k/vkROhd0Ct01LZ
         hxUv03v5fMZcuMHRBjP1iCrxzGiHbxrk1VjwOWxRAzvs+Lhcg2ZnFGm9vZ7Mi9t2TQBt
         9dwN26txz15KjlhJdii8VP/hKDk67oUnoNsKqX2s6wgvcT0lx0iiT4bwe4e4xHQ3901D
         YDy9X+MQ1c9fr540nt0AJunGLOj9wS/89Mqh+WKg3KEGXuSF1VpaQnO1kUQDM1eMGrj8
         3tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772796363; x=1773401163;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CY5l8ywo2gfwV8s6iTms1Cd6/EkzG/nG2cleNFaj6AE=;
        b=QBmL+k51RrxVbNiWOEaMpptCufX4YXmXz8b1PVeKH25liPW6jxJF+DGeC7RzqPDC7V
         YfBCOIn8NOefBYOsVP+Hrd78agCjNjK1OutuG2V8iDiB2C2ok8+YbtGC171UyQIR0U5l
         A59sHNPsyHp1hy7crqo9koPA2GOLsdhZ+2HcZbmHZQM8GxmLMPt+8rL43izNS9y657g8
         sHfk/jGaxBHAlMTH+4lHfN3ZHICBc8EQzamdOZOeJ4R6MKkxeV+PtpokLCDqGWCfw8+F
         sqoJs1PNfpALF2VA9FwEaFZOKCZIWUpFcL5o/8YUH/OTIXkJ424GCiRTfg2FWOpK8xKH
         1Scw==
X-Forwarded-Encrypted: i=1; AJvYcCX06bdCV5kRc21ZXR+61A1rabMlNBE/LT9yoCYQnuZUQuLEm/r2XJq050U+M0nMV43rwO2BdSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkTcFh1TtWRg3ZWaA8DdTGQQuskmq/lcsQ6QpTCSKFSiHHEBr
	oW6wwUnzc3RuSFkXMP6uClyI6eQaGyC/oBEfG9gIafHX++lSlokFAkgebsR+nFFy+f4=
X-Gm-Gg: ATEYQzx3hd35wbJg37MYMbmsm8JFtTwWtnDsQLxdU5w8XyhZuOCcrSOMd+JZ1OghbuB
	mOt0XE473RfQ0xKWVnyCB7sqF+Dvskxe+DZLSi4oyy+IKLZhrDdimQkcLH38kS/sCdsEc7a+eqh
	uarGeBuseAy2PjGV0NuNAZ8vWjNmGFqedTZTgySfePIpbDs2e2bh9CsLHtq860AX+k4+LJRQosE
	mWxWhw5xhMnELAJlr/KclHrC896J5Wktz4F1mz3BuM+PR6uM8U+3gL7RRdwplE8JAGHQGLOx/VP
	y4/cQfIrkF8zMGP07YEX8HJhZzGHS3afM/nyj/JhxjbHHwll4MFwdTAmlwzuoFxFPO3PImWKb94
	4geayVH5+5eY/Q9wvIjIfhMcz8jUmnm6Yb6Jk2v+IKdQaq7ooLKY0FcGBX7o3tNft39qLV9R2qn
	UMe5xIPj4GYjHmAOcyPo5TWqTDvfqV+Mgj49WtgGbH02X6SRwuUpRUKIRe9PBr9hg=
X-Received: by 2002:a53:e1a3:0:b0:64c:96e9:43bb with SMTP id 956f58d0204a3-64d141961a1mr1289970d50.34.1772796362748;
        Fri, 06 Mar 2026 03:26:02 -0800 (PST)
Received: from [127.0.0.1] ([2601:703:4183:37b0::7115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm555642d50.20.2026.03.06.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:26:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, Mehul Rao <mehulrao@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260305193146.304526-1-mehulrao@gmail.com>
References: <20260305193146.304526-1-mehulrao@gmail.com>
Subject: Re: [PATCH] ublk: fix NULL pointer dereference in
 ublk_ctrl_set_size()
Message-Id: <177279636192.680057.1248751372115881016.b4-ty@kernel.dk>
Date: Fri, 06 Mar 2026 04:26:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 61FB821FA1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-223327-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Thu, 05 Mar 2026 14:31:46 -0500, Mehul Rao wrote:
> ublk_ctrl_set_size() unconditionally dereferences ub->ub_disk via
> set_capacity_and_notify() without checking if it is NULL.
> 
> ub->ub_disk is NULL before UBLK_CMD_START_DEV completes (it is only
> assigned in ublk_ctrl_start_dev()) and after UBLK_CMD_STOP_DEV runs
> (ublk_detach_disk() sets it to NULL). Since the UBLK_CMD_UPDATE_SIZE
> handler performs no state validation, a user can trigger a NULL pointer
> dereference by sending UPDATE_SIZE to a device that has been added but
> not yet started, or one that has been stopped.
> 
> [...]

Applied, thanks!

[1/1] ublk: fix NULL pointer dereference in ublk_ctrl_set_size()
      commit: 25966fc097691e5c925ad080f64a2f19c5fd940a

Best regards,
-- 
Jens Axboe




