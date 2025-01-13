Return-Path: <stable+bounces-108536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED041A0C51D
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3271885B8C
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E6C1F942D;
	Mon, 13 Jan 2025 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGN55zD+"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586791D5150
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809603; cv=none; b=R+GaQ7Fae9A9yzFWfLRWFbaRivysHP9CV9uAu7F2JYbCv5vMUKjR9IONM0BCl39AMF9FPXwups7nB4IjQYfckupAb2DoqMTekM0dLU0WbOFdG+2sE9vg8Lu7f9kGa449qbdA78p5RCp7sr4sg2VG+Vu3aIMAr+XP9Ld/7YjbxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809603; c=relaxed/simple;
	bh=FY3CAUHnUAGPlAvnTqBwytKqjfIe0H96ZK2+kvt3Gpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNgbD+hANurzUoZztFk86rVye81tzxu43qQRtIhv2FSk0Xq0F1pxa9SAp6kPdWhmcke0ftms/Kfj+tOgKj/O8i5uoiV67Nnwfu3OxuisjATmoIQhYGI8TipK4l4O0zlAowiFNM3LATjHaVO3ypIIZsP1E1osiCP7CYd1sePavxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fGN55zD+; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-84a012f7232so188885639f.0
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736809600; x=1737414400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t98L05cLqoN9QlNAdFWwtAB2uSyAKNpsq0R3tlTJnx4=;
        b=fGN55zD+QPKLTIC1ERc58hM9umFVkrs3t9SSVj3jKPYQaee3iswV/0spT0NsKCUget
         JEyaj3elRNTisN9FN7FtU5LE4NLRwVksQ6Iqm7IzCO96TvYeJpyB84YBTzrg3KQtZIFP
         uHobzoMZG9AS9FwjzAsqrxgm2ABSeadHkVotc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736809600; x=1737414400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t98L05cLqoN9QlNAdFWwtAB2uSyAKNpsq0R3tlTJnx4=;
        b=dOYEZARAXnO+xxg8LAzspMIUqxC9DUsevQMoO1L8zPvMYinjoU0F6w4ETIV35BdQy/
         XTq/LfLH+9SB6V+wab/PmCpZmNaphF6Xfh5ov6/ST4hMQuEUtyH+cCa4vP+hdWxAVnqf
         qgVmtlxD2rUsCO/5TvAwh9K/a/tKEmPg5KWu5fTzBnuHyJdmAw1xeKUWLf1x5LZLZ0li
         LZ3yUR4m7jY3sOV2QiqAslUkQiYFicjTACwnoiTjAODnSjTn1VqSl9iEMtRSbGJBfIhM
         L1GczcjzPbQRBtlm6doiphp2DFrWzi3puSDaHzivFohHrCkbhnRIiKOeBTYXkP3HVv0c
         rTgw==
X-Forwarded-Encrypted: i=1; AJvYcCW1n8kyfDx4yvF8GEj1uZ4eG6EVVAsjQP5icVQC8ZMX4VzGBQLplvtaR2Obva3L0Ht4zCR3aAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynvkradB9lMDaMUoQaMEVJvLlJ9z/ZyBt8FakFCocUOalsJroQ
	dAEay9jsFX9KUtMdbXxWfqStUq6EpEa4xrz+1YuYmilb0l+ApRqmsvTn561Umws=
X-Gm-Gg: ASbGncs6/CNSkrawVQJ6eG4JAcDP0dlkbqOPvIazeA/afn0nkwF7qTIgRpybcLgWJKd
	k4Vj6qcl9pn3dJcJK5fTKpqOwZsdY9tqqM+vYxf1ePR5WzQiaDTePqEk1iIEaE6sONnEaclQBRm
	PweR/FPLKqCSBAeLH1oLj366PADfzeKud6HPiWMujWdSbROa3ngqgY7un/1DHeCSs0tBwvXE6GB
	Mhr/PWeIoshtVyFCyDVbdEU9HJf/Qa/QjbZzPGxQDxH+Cvut8S9PaG/wlah67o+6P0=
X-Google-Smtp-Source: AGHT+IH8D8/WA3nsz270K68ibq75FwpYAmp8r79kGSFWGw5muQ30GDD6Uv2Knph7vskIzmqScVtI3A==
X-Received: by 2002:a05:6e02:1a8f:b0:3cd:c260:9f55 with SMTP id e9e14a558f8ab-3ce47570cd3mr131591595ab.4.1736809600570;
        Mon, 13 Jan 2025 15:06:40 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b717838sm3014196173.102.2025.01.13.15.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 15:06:40 -0800 (PST)
Message-ID: <15339541-8912-4a1f-b5ca-26dd825dfb88@linuxfoundation.org>
Date: Mon, 13 Jan 2025 16:06:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix rseq for cases without glibc support
To: Raghavendra Rao Ananta <rananta@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241210224435.15206-1-rananta@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241210224435.15206-1-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 15:44, Raghavendra Rao Ananta wrote:
> Currently the rseq constructor, rseq_init(), assumes that glibc always
> has the support for rseq symbols (__rseq_size for instance). However,
> glibc supports rseq from version 2.35 onwards. As a result, for the
> systems that run glibc less than 2.35, the global rseq_size remains
> initialized to -1U. When a thread then tries to register for rseq,
> get_rseq_min_alloc_size() would end up returning -1U, which is
> incorrect. Hence, initialize rseq_size for the cases where glibc doesn't
> have the support for rseq symbols.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---

Applied to linux_kselftest next for Linux 6.14-rc1 after fixing the
commit if for Fixes tag

thanks,
-- Shuah

