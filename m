Return-Path: <stable+bounces-28102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D79987B3FC
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 22:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534BD1C2316A
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 21:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA145644F;
	Wed, 13 Mar 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UIArm7EV"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6E5381A
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366989; cv=none; b=ItpYKPF+uVx3aqK6b/NyJzShcxGXM+PB5QXo3rcDMsDD8LVuGFbaO5o7UEqUa0aZYN4YKQNEHDzYhcgktlEiEA7ypzlQ5RQvxDBOhQAeBp/gBXTMj78Cs9bNDwgoJeItwyFVLLlRYqmp8WY2+Bavv6UV64AZKwwDJouXPMtkUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366989; c=relaxed/simple;
	bh=pidpON54GW2OoE9CebhOz2WDcDEEEN6krgz/X36cGXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bRtGFE6gq1qAHTD8BEhxmDlJxxoGpRiTs3/vEH4xCb0kHBGpe3L2e0ENZoPgl5UpAqXlYlAmWJ2WQzQf/R2WFt9t455dHE0KKdK6pVgwXiM+ku/ieCrQdh89CFaMWwpAcDTmltQlnmQ6lc7+2yY532qV4BRAvwZX6VVEuNM+zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UIArm7EV; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36649b5bee6so538865ab.1
        for <stable@vger.kernel.org>; Wed, 13 Mar 2024 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710366986; x=1710971786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iWZ6WN+sGJpmwLxRnmW8Nu23rbrdVhJvGirE7oMTKI=;
        b=UIArm7EVJMWBwjZ8dpgqgQfQSKzQRX51ZhOElGut0kRT0FctTsnKEXCEIZG9hzqDhc
         tCTyFeHLo7+0cf19eyCazT66TCFZXtueaCjFpSjNZDybvFQx81KR4I4jm7zqICxzOy36
         MRWgmRJwO3FalqxN6cGbkM3vMlQcIp5JIYxlTwHqCq0ZYukdGsoSnFJMX20Pz3vKvEII
         7npW2DFlyjA87XFMsh1oElsDb67oc3y88dku+6TxM1kNjNgniyVcOBRsQZESdvhDNX0w
         OXAdgrGWo7tzgrmu4IMYXQvIDq66pdPSbc9vNFFmRPqLxjS9ausonWy3SvlNH7ltRpbO
         Rd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366986; x=1710971786;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iWZ6WN+sGJpmwLxRnmW8Nu23rbrdVhJvGirE7oMTKI=;
        b=uRdu7mXGYvwKUQYnQdFTuB/HGDWZWK+bvTgItFIZrD+G/spj/kKg1RWkj340sY5YuL
         FsDUeiT3t3Vk6YJcdjPO12KqVn76Ggymc0L/M4YLA9j05HchMW2ks8j8ZX2Gr7gPoiv/
         eeeqBW7YZsqAq3GI3aAQkN8Qdt936npDkeZeOdFez8M7Hfw/2ZT1JS16XB7CpyDPwI/X
         3aOcpgIBE1A1OQTQElCEHeoYAkam7PiI53pnli4VjnhpG1TFxjInWnREthc6/58avLmK
         6EViEvG4HhO7O6+z4aC4AQ4urLP14adBIywng4v3dDvlOwTMVAAp7aph01LM9n40eaTS
         tfGw==
X-Forwarded-Encrypted: i=1; AJvYcCXa2kC/jtR6D6+x+S1KsiXYd6GJxd3J7R9EkWEO26Vk+Mp9w/X17J66F2HaZDdXiexkUtalnWzj6LoR2RbrjI5REjrDjwf6
X-Gm-Message-State: AOJu0Yy9/gyf39X/3F7wPeQQqAZagmu6CcEvWuu/uyyhC4jqtsA4M40k
	K3XmOvdHAsPRCs8orMnm6rnNiu1NiClRkQF/JyH9DzZ1JQhEDFq1NEOyWvYiJjA=
X-Google-Smtp-Source: AGHT+IE/xLkfGNFymYNc+g5qKiot5aXuVHBXHPVH0zz8MpJV0hR9J89BmuxJq1ImY2nHQCiwbu7duw==
X-Received: by 2002:a92:c548:0:b0:365:224b:e5f7 with SMTP id a8-20020a92c548000000b00365224be5f7mr14176282ilj.1.1710366986625;
        Wed, 13 Mar 2024 14:56:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q3-20020a056e02096300b0036426373792sm56959ilt.87.2024.03.13.14.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:56:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Zhiguo Niu <Zhiguo.Niu@unisoc.com>
In-Reply-To: <20240313214218.1736147-1-bvanassche@acm.org>
References: <20240313214218.1736147-1-bvanassche@acm.org>
Subject: Re: [PATCH] Revert "block/mq-deadline: use correct way to
 throttling write requests"
Message-Id: <171036698538.360413.6777553266929994961.b4-ty@kernel.dk>
Date: Wed, 13 Mar 2024 15:56:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 13 Mar 2024 14:42:18 -0700, Bart Van Assche wrote:
> The code "max(1U, 3 * (1U << shift)  / 4)" comes from the Kyber I/O
> scheduler. The Kyber I/O scheduler maintains one internal queue per hwq
> and hence derives its async_depth from the number of hwq tags. Using
> this approach for the mq-deadline scheduler is wrong since the
> mq-deadline scheduler maintains one internal queue for all hwqs
> combined. Hence this revert.
> 
> [...]

Applied, thanks!

[1/1] Revert "block/mq-deadline: use correct way to throttling write requests"
      commit: 256aab46e31683d76d45ccbedc287b4d3f3e322b

Best regards,
-- 
Jens Axboe




