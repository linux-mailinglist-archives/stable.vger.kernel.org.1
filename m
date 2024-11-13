Return-Path: <stable+bounces-92963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED819C7DE4
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 22:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA61F22E3A
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 21:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D018B499;
	Wed, 13 Nov 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1mH006q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72921632FD
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534865; cv=none; b=p21lMjVu0WoAcLwOHtCXS0upg3KhOt7MvMKpymBcrjPagK6fXx/zjv4bn6Jv/2QNOQ//ld8lGK+iLrKcZXR/Aoyw+qm7w6daszVxjsSq9o/9PjE2LlaKhz90aLUqYwuLpoLJjvg67BxTFq5TGkLdWXZ7y9JXMsy/sZy+PDZJa2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534865; c=relaxed/simple;
	bh=Mr2QdsB0k/jh4DLmnDo/SlAsfaP3D2NYxIGTg57QvoA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlyWLh5BPXyHbSpsxZ6aqCuWiZtB8J3PrEMoupWdy+7WeLO9UhpekiiVnzfj11BJrzs+tcXFoB0HzW5q2G4wGBkj9gmAFQMaapCcl5hmykKJK4/Bc2iMU1LJyni0KkOvEnzsyiMw+9lkQ53BMUpLa5R13vmkVw6xzB+sxM+DSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1mH006q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20e576dbc42so78196715ad.0
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731534863; x=1732139663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NunyBZUoifGXMzNtmqjEF4WY7e0r+FgMNbotXvuJCMY=;
        b=b1mH006qQs3zXl88YnEt84sRn80x3duWIPiOjPnUwbXk3NqblzIbtPSxJMkgtGzbQ6
         B2XheFExhXaCYhNGgLTSZmN0GgSUALdrsTgYHuIa1nToIdBlFAICtmJ00JqSNPCyBACq
         EMg2IgyLZnPxqmET5ccdAcvCrJFNiO8EUKP+gTgxBMtV4OfM3RpEF0RnOhtbN3mOCnGZ
         2gX6n5FB4sfXQ4UH/SZ1B+Gsluio3tmde82FLhmpBtfrgyS75izIL89c15kvBC1swZX7
         KvnDbaA9KsaSVNIScDb8xTSvwY9QZ7TZfmB2wk8Qj/RR9Uq+0+1IC5xudYh3W4wFr5dg
         Bqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731534863; x=1732139663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NunyBZUoifGXMzNtmqjEF4WY7e0r+FgMNbotXvuJCMY=;
        b=Il6JVsT8mHB0O3Jhvkzb2JKbUl8VIBqwzA6Dcd+5SAvKDoWVR1T/gUeamLqnV1qKUK
         iE/0e5ttnIPSQWcDMmG2AYloaQCTfu2745oydJjIeWqlUlX/fCYKHFXWS6LJ4/2AZcHX
         UEfuTuKYbKZeErK2eSWtWlinpikNmEL4L7FAAjn17J559Q1Z770cWXa0DbL9X3H3VltH
         zU1AhSYO3z0mNOK6Gz7K/b39V97i6vLhfzSxQ5+rTQja0uV+6z37vufY3okk+ElCVE7M
         YW3JgzYKBhHI2mwJ0Q/U2jnVK2TfamWWfwmkfq1XfM8LN2wNmX+KMuahI3FOginn3Pnn
         KAaA==
X-Forwarded-Encrypted: i=1; AJvYcCXEiQs4/2B+xyTlj+cpd2knRBewGlmoiRh+6TLk7xC9vbUXB1UFWtvsKy0qVLlgouxFLzkk4UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtt5Uw6RiMdIVw0Nqlem07aa/r/Jkduj54/BTsa67I8nOh2dc/
	f5FDeFqBjGmmaYmRPaHFTeaB/kRWxJEYwgYRkeI6BVVXkiIcVmpXJk8UIw==
X-Google-Smtp-Source: AGHT+IF6eQLoMeC8NkWFLVKkgcu3XGZ1Y6KtAoRmMqfhHyvJGWEHpg7j93PGTb9WXpni0RUB8Pu5cQ==
X-Received: by 2002:a17:903:2283:b0:210:f6ba:a8e9 with SMTP id d9443c01a7336-211b661d251mr49741305ad.19.1731534862979;
        Wed, 13 Nov 2024 13:54:22 -0800 (PST)
Received: from DESKTOP-DUKSS9G. (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a33bsm113183645ad.239.2024.11.13.13.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 13:54:22 -0800 (PST)
Message-ID: <6735200e.170a0220.3cb599.5d77@mx.google.com>
X-Google-Original-Message-ID: <ZzUgC3YrLRPUieLR@DESKTOP-DUKSS9G.>
Date: Wed, 13 Nov 2024 13:54:19 -0800
From: Vishal Moola <vishal.moola@gmail.com>
To: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <motiejus@jakstys.lt>
Cc: linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] tools/mm: fix compile error
References: <20241112171655.1662670-1-motiejus@jakstys.lt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112171655.1662670-1-motiejus@jakstys.lt>

On Tue, Nov 12, 2024 at 07:16:55PM +0200, Motiejus Jakštys wrote:
> Not much to be said here, add a missing semicolon.
> 
> Fixes: ece5897e5a10 ("tools/mm: -Werror fixes in page-types/slabinfo")
> Closes: https://github.com/NixOS/nixpkgs/issues/355369
> Signed-off-by: Motiejus Jakštys <motiejus@jakstys.lt>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com> 

