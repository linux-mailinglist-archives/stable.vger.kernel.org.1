Return-Path: <stable+bounces-89112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2D39B390F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 19:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C861F2279D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193B1DF278;
	Mon, 28 Oct 2024 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L4+wREU6"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D8186616
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139994; cv=none; b=i8cHCreDgerYCW307wbDYLWbRk5mErwLEN+lNtNxv+2Zo0kGKbs+JIuDAkAm0rZirEFF9DrkNt1Ly1cuW/ydFk9c41+SKrUwKvRFS5WEe41e1eLWof2jwtPpFwnl72nB7CpXfjSaor8CD/IEI3cFRLAYBqo9tcaSzwlG7VFGFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139994; c=relaxed/simple;
	bh=kjeL1hpyjgBR0kSY2Up09JsHI+Z4gyMAOWaiZ/zGdgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qg87jN3awcU+xRO91Uq/sZOEcHsna2UpqH7XAy7wUL4qucRx7e2wF2vtv9Vz7/bmlzLcrsZJFQEOK89GIlYH1qWFI+uoCm+uYJ0kUyU7qJyrNc+y9iuHEiIMzFs9uSggWdxBw/cZoUbuVY//P9jpfHa4C0JtEt6K1PvO+chF7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L4+wREU6; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so4733838276.2
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730139991; x=1730744791; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjeL1hpyjgBR0kSY2Up09JsHI+Z4gyMAOWaiZ/zGdgc=;
        b=L4+wREU6UfrN2farsaigqN7vnzcA6u/hV96qAtaV9kijujDg1LeE7ydXN7zyl/Z8hj
         zRIBwx02Zp54X2tFOrXS4/A23lrdHZsGXqPBxO5VHpxkZtnQzi8IC61Cu3KtGVY8lA7F
         2vQRGOG3dCxe2TumYsWMGgUIS7aLPFke6KEDKpUdunoYo0DCOGoTE95AMVkjgWfxe70d
         tFzRbGB2BW1pW3yxfg/i2NnVwwd7/0YHxy/eXypQBja8+Lopd9ZKhpUmZLp7VSWvQT6T
         AH2k/ZxsXtkTEsNvOHj8EryiAsf5Md8HVAyQuIZeJJFSvOlL9GipzqhTOCK+qJFV7Zuv
         MGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139991; x=1730744791;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjeL1hpyjgBR0kSY2Up09JsHI+Z4gyMAOWaiZ/zGdgc=;
        b=cNs8AOFW0z06IoEgcZcsTK0U0BIgYDf3Ut1uBZ3oon5/KAqk4w6p5UccvdA2ST5u/D
         9k58MZy/HFOJ5QrfLZw/ho+XOw2FQoMN3/A9Ai1EEWcVPJxQ7Xy4morLUz6IehMVaWga
         2xarGZF6d2uLnAJrk93a3xR/iD2csJ5btUMAOt8cLi0MM/+PsQMA0X8ezu6DkBqU2/AA
         OR9TiOtBWd/C8oiJWG/3hKPa6ljvLNUdWM6FwJkuZ78G+q5803SgKg0Wu+WFkhwWkjba
         EUfgybstGPqMMDdA3F0Jag9nkz2Ieo3Wp0A+9Bu0raldAD5LvIu6U1NeqCNLGyZksfiZ
         f4lQ==
X-Gm-Message-State: AOJu0YwsXQMQkTrxb1v++IX7EIOc2QkPa/GfUM0lw336NkPej+RYz5Sf
	yNDD6p05OMLyYCxKaEqs+fgD3k7pw4z6KmNmwXQeWVimxbh12q6m2WC4VHR7rxKatMaae5/mOrX
	xX2758nDTmD29dkqJrT1rOCR0Qyx6lQrywgxwWy8X668RtFFF
X-Google-Smtp-Source: AGHT+IHBxoEdRd8OjFth9eXSZGOTwNSu5xJ4grTudCr52ng+z8LZ77EmnN90Desrtt31dJiLaX8XaVlluob/
X-Received: by 2002:a05:6902:1b0b:b0:e2b:d93a:e550 with SMTP id 3f1490d57ef6-e3087a46afdmr7217067276.6.1730139991111;
        Mon, 28 Oct 2024 11:26:31 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e3079d9e0e0sm352154276.20.2024.10.28.11.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:26:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 142B23400FE;
	Mon, 28 Oct 2024 12:26:30 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0A460E40ED9; Mon, 28 Oct 2024 12:26:30 -0600 (MDT)
Date: Mon, 28 Oct 2024 12:26:29 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Xinyu Zhang <xizhang@purestorage.com>,
	Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Subject: Remove "block: fix sanity checks in blk_rq_map_user_bvec" from all
 stable queues
Message-ID: <Zx/XVRgyeCeaKrj+@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please remove the following patch from all stable queues:

2ff949441802 ("block: fix sanity checks in blk_rq_map_user_bvec")

The above patch should not go into any stable tree unless accompanied by
its (currently inflight) fix:

https://lore.kernel.org/linux-block/20241028090840.446180-1-hch@lst.de/


