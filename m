Return-Path: <stable+bounces-197571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E837C916E2
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 10:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0363A5A79
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF530217A;
	Fri, 28 Nov 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPkBbI9G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA9930215F
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321859; cv=none; b=csrILkWbaeoyzCR8TUBiQcU2vBl/gUBGh5rY9zrmCEKUcg3Z0dVpMnVjfmvolEJX+7Kyw+Um8zsZ3IHSCx/+IxwdRUkty8QA3/eXAfq6UNDbx7u8pzXl9qEKFebe0n3ny7we3rvdHpRnGrw98wo06pzKKcyrBMJ3MzEGvgR9YB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321859; c=relaxed/simple;
	bh=ED9nuiaO8n6F6aMYH2jutdJWyKTjRdS1+Fiwm5emSdo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Ki8eJWXgPmV2jJOCRyfjUJqo4+EThjSQs5Egf/4T6CY+/j1wbk0tjbxgb+RNgaFGhfYXV6VpGGnvbDR9R4IL4Vz4bJK9tYgcxU7+4QPK3Fv3F/6ZEHCuf6nsSpwRLv0jcLNd4ai+/7Iy/9T6BLOzcqoqGdeIHsUnyUPJs6BPaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPkBbI9G; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29806bd47b5so9826565ad.3
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 01:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764321856; x=1764926656; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ED9nuiaO8n6F6aMYH2jutdJWyKTjRdS1+Fiwm5emSdo=;
        b=FPkBbI9GiVnsb0M/Zj7McJfU2Rtk71JMpmlhMLnQROmpakm8KpEhBPOSFP8yjxQ7UH
         +65YEffKC2iIX+uJlsZpfZ8aY8PIJObwIgxoeuvVU0n/+qL9brNV/WK9b+k0NvG/fzB0
         5pp2cZa6V84u9RvDGUVafgO76IUj67obTzfEvgG5GYvt1zEhFtkZQcjnz01qsNZHHXfc
         cblaFefKaaQk1087WkAJajHkKM+Vdpp+5CtmxIP6Lq34/0bPpFOY9tzEM70yoCTNqSKP
         xEzPumm/cUN770xG3MvG1XY4jnIhxio13yKxtxggjPdz+NauPGKKoiMMs9Buy01QPnKr
         YLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764321856; x=1764926656;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ED9nuiaO8n6F6aMYH2jutdJWyKTjRdS1+Fiwm5emSdo=;
        b=C97DIOI4JxU2dfH0/IMDVzEc/uhOdXXHOp3YO7n8F24qyMsPiLpwAARpi0T0JtArQB
         FeR9XXdw4J7SbsJpbI7gk3JFBIkOB6Tb2R/iBU8+hjS4Ib9oA1xwA7fie/vWUxDzDFtH
         bJGh6gJXKYIPgKc4XHgD7TQLKBJfywcn2RTJw91MS80hA9zuhHiT4WMWKOEKZib3/D8q
         kZV65YQDDlC6KFTd1Ruie/+BZ+Z06WairWT4qjK9ADanfWuFT2cVDE8teozPS3irWopN
         GQMOJv8CAWug4b9CQ0yhiQmm23I1gtir7zjGtL6eJ3hqcL7dOQoEsy1hYy2tEN1L13dm
         zu7w==
X-Forwarded-Encrypted: i=1; AJvYcCVl8VKs1Iugeyz27vpdINRWvFoLIeDTAGpYfnIZrq0cRlbxDHHeV6PuYRoT/p2gVPa+FszDxek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGu79f7OUC9yKwHiAkBMONghebdG3RxqyYjq1G3b+kdF79g1r
	+myoG+2vyzgqwH9owRc5QYPOl8oOrUEC896kdtaaDjkzh0S4H+TtIWFV/UX7XQUz
X-Gm-Gg: ASbGncvHeFQCLCGPrh2Y62K9Ks4HDoYbwnsrptOHQo6OqyvPucVQYeWUUNak9ALtg2o
	OcgyBigWf/yl16Qkah9229Q5T5b/Y6Yt86nvpBAHS0/UstTaDG9aTyoi5r08lYjjlHuC9pTbDjQ
	qtRSlGJZrI6OXQ8pPe5wDgM1jgVFI3aHkdprHaRMp4+eOUwB1Y3j4gRbE0P/plNdGtvJx9WdI6r
	+6Pcn7Mr8iVAz3k+ZGk+fn+EMYehLKmeRKT9pIiBIEriFr43jmIjnYu1ttww/T+XyYDCN6GfhDH
	9jxm5l8eYOt4gAkwXWcQJ4xf2z0hVp6F/tELLW6X92eOVBQSE+3kPN7c/0HfZv0fv8KZ0encShn
	2HbT3hblU4ZF1JOQCmi/iVdZF3uslN10swHFH3mBFA/4Gy+HUMbVOPJZjqS+QOifztMW+eg8yap
	xaGYzW/xV1rAmL2l3U
X-Google-Smtp-Source: AGHT+IFkvqq+4XxuQKa/k2q+LQMu+sa6LTsS3nR8WXj3JiP/G1PdBLLzpGBMoYNmd/LwjyGU4dN/Ig==
X-Received: by 2002:a17:902:e54c:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-29b6c3c2913mr349029165ad.6.1764321856487;
        Fri, 28 Nov 2025 01:24:16 -0800 (PST)
Received: from dw-tp ([49.207.234.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce478762sm39554625ad.45.2025.11.28.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 01:24:15 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] powerpc/pseries/cmm: call balloon_devinfo_init() also without CONFIG_BALLOON_COMPACTION
In-Reply-To: <20251021100606.148294-2-david@redhat.com>
Date: Fri, 28 Nov 2025 14:37:28 +0530
Message-ID: <87wm3amsof.ritesh.list@gmail.com>
References: <20251021100606.148294-1-david@redhat.com> <20251021100606.148294-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

David Hildenbrand <david@redhat.com> writes:

> We always have to initialize the balloon_dev_info, even when compaction
> is not configured in: otherwise the containing list and the lock are
> left uninitialized.
>

Agreed cmm uses balloon_dev_info infrastructure beyond just
CONFIG_BALLOON_COMPACTION, so it should be initialized by default.

The patch looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

