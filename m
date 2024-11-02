Return-Path: <stable+bounces-89564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0739BA08A
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 14:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009581C2120F
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF018A92E;
	Sat,  2 Nov 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLxkH6Wl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F31E515
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554188; cv=none; b=lCDqTSv+05uaHulc2qDxplBRGJ4OpSDBuvAZMlZgvdHfIeB3gXEpDertVec4OFmeXjRIyAtweBRZcq6Hl6cJGtfzivXUScclE3pE3FHN9y9Gng+YBTX3z2UMSaYU1JbOMFffSXJLSFUfg4zgB4CbN7q1mHlvIpyYSizPI8r0ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554188; c=relaxed/simple;
	bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=r9bVGypP0Vzk8TayzBe9HPbofud/RO6p09j/w/gGJtaKSYuViqVx6KNDar3d2tnoChgVoopuZNky3HABkRUL+NT7vkv8E5aLs0/p1WF+haswI+vyy2C7hYjGVFa4T6j/3D6K4L56ik/IG3JgJ1utAgLaPeIcH2BPQuZQIAUHkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLxkH6Wl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9aa8895facso466379466b.2
        for <stable@vger.kernel.org>; Sat, 02 Nov 2024 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730554185; x=1731158985; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
        b=bLxkH6WliWFR04aZUf35ASuzmEBjDf+M306svSiAwTz34+xQA7YhUgvLxI1c+yjL4K
         n/FBn+rktiJ8dIkwi+2Z4uZLhoXB0jd0XWSunIaFIEUrmdmclfG3FrzneqFzbAdrSAbc
         X7XNavHJiUSkjWLcO9MJ/ZDSXYnIU78FfYvMJqmfP8COKfDDoNmkThpqUV7SBSgTxhtJ
         ajyxHAD283IEvnJjJcWoejXCW9KIvwuNLAUahyXM8Q0HTDRHTE0hYonL4XDCj28gY510
         jxVBo69tJKQGpeEncEWRIcc8wv2ABqIhk+2PJciSeGJ700wgyRFdSbIR2iS/Yst4uJWM
         QveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730554185; x=1731158985;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
        b=tR2O9mpRSmJFLjtk/O8Mp9OSzGx7vPecgXc34ZNjQhrzNpDZUgQbJ0IY/bi3UO6gPN
         9GTVF+WeEqtnlKW4t2f44SRYpebIo8biMRbBc2EmUz5dLFEj8JVcWRMZrqshnfROjYWO
         tCLp7epoUjnaSZp0AzJ/lV78mRv9WUUwR9/AENaDVLR4LfEQbIjEcwFk/CgptY6vzqWz
         nBYJstCgG1+pQTR7pfjIEB/paC/1eRDR92mBKNZ2YAzQhNgw1uiNy7PQ0YTNvfJzGlgK
         olwfgmrzGTfoZxSw4jvKLi+a5FisVhd8VVUhUsU7zpszBhCnmvmedcObsmHh0a+CH6yY
         mfYw==
X-Gm-Message-State: AOJu0Yx1/CO38VmHHkcRS1Il9aElyenFKFMsPRlQNCRfjdtKAgoOZR53
	vd5ULP0YxPbKmwzndBnZHGouGXlZqS4vbgCiswiQh6pahL+Mdkccet0Gcg==
X-Google-Smtp-Source: AGHT+IFjXaM3VBW+JfUoLwPkxYX3RrrBYx7/UndbFFphHva9WfPcUOfsIYsNjRvdwLFLLBrknjTVvw==
X-Received: by 2002:a17:907:7f07:b0:a9a:2a56:91f with SMTP id a640c23a62f3a-a9de5d6ebcamr2657595466b.2.1730554184729;
        Sat, 02 Nov 2024 06:29:44 -0700 (PDT)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56643f70sm313382966b.173.2024.11.02.06.29.44
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2024 06:29:44 -0700 (PDT)
From: William Cheung <rinky.khatun.doratana@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <f1fd94db8273edf7d7eca5b00af97a8e7314a6c000a745020c6548e005f582d2@mx.google.com>
Reply-To: willchg@hotmail.com
To: stable@vger.kernel.org
Subject: Proposal for you!
Date: Sat, 02 Nov 2024 06:35:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello Dear,

I have a lucratuve proposal for you, reply for more info.

Thank you,
William Cheung

