Return-Path: <stable+bounces-69743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91BD958C88
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C731C21C69
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEDB1B9B5C;
	Tue, 20 Aug 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvMXAkzN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ADB18F2C1;
	Tue, 20 Aug 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172219; cv=none; b=CK7WQLNkIsEx2TcbyHloJo7bJQ7+WNh1Soo1jPYBceJ0P+4FwWNcjDw1tNyx53E/kA/CKGvEK0V6ccz5WTEY9aXvkcGQUdNrMiSb7UhdvaQeEDacOhhU5l3aJNEBkZfznnJDbxygiOgb7cSyF31ZA9y0dKzKGVLjKyqj6wuE5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172219; c=relaxed/simple;
	bh=a2VlY9wy8idDBqSuGHRq0DuxXKEl4cq3eovu8pexIos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrEa9EoVUsvnzuUrhIaVsn8CHYEHMbUrEe7o52annNt40vhU4OOcPxidA4jY2RkyAb9oa7CzwNLeZyJaJFAV5XkTEOBZQravxtR9IObr3y8zFokJBFSzDwi5CJHEyOPK4IFEIerKER4/frzW1L2cK1KmjMt6YsIjoAVGifd7sJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvMXAkzN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7142014d8dfso171253b3a.3;
        Tue, 20 Aug 2024 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724172217; x=1724777017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQdEzA+7G+pP4434ZW9Qd9qXYcSAROBFOoTvIKQtWNA=;
        b=AvMXAkzNRtobzMPrbdLgg9upJZOggOLoJsFF5VWYLz93u6sCHmHfPTQVGA8lh132fw
         Ve8eSbqSIQflJ/K6h5+AGLwxMxvKsY/1PxQX2Q675WLwY8UA4dLD8J7A5lRmqQ/MBjJo
         bXkFbtRL5rFYn2+CB/QdAXzSwXKRFWeiA0iXsnJ71vzKM6D2v1nI26P2ARk69kfyZfgL
         2Pibqv6rWCsKblaYKeJqNB0gr3mRz9Kf+xtP9nfI6KmeCl2FsPuFbiveTVQb5FfvyIM0
         q+GU9vwWKrRodo8EF2tAdeGuzE6EHCbbkYnv2yd7lQTtMbavzHaRDeiPqHqPKVbGLcfo
         r5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724172217; x=1724777017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQdEzA+7G+pP4434ZW9Qd9qXYcSAROBFOoTvIKQtWNA=;
        b=Yjf/XAWIj08a0+rkKHb7nbGGQ5MCt/xUxeO7DD90TJmRLy7abSXwaiLoEJr/pukan8
         VC8pLQJuGak68iwop5Vk8TIXNnAT7XJqRUQwkURjb6OWLuApZMrQLSEMnTZDdyUelpck
         1ROMxALUZRCVtvZgRTYyqlCKyADPkWickAkwNiCTvdls7Tuh2md8XECVwpP2/sAhgH07
         +i6X2xMurIyqTyRQz4Xx/OcCmTpuCe3smGonndLmx4s4F4ijeu70MsZva5bdXBNkUuTo
         TgkaUSFcs3MaOuHEGohkYqpgHrcg1hZH5KsQLWrn8qI2c2MRbX2TjzQxzSiBIUtJvJOM
         TsMw==
X-Gm-Message-State: AOJu0YzNIHpHD4tLssPpKg0DcschT5JwvnayBu2jTObxsuzdApPKhekT
	yI9J7SgKvif5vRU9kX3jF9xzDl7Yi1fAxxZQAnjxeLFrXCAzh/k3ol22+A==
X-Google-Smtp-Source: AGHT+IHPRu2bYKYbhWpQ3cZQGfQEv+Il00hd9qBpr4fF/Q+KNZky4k0jbein0IjK7fzhL60ai7rT6A==
X-Received: by 2002:a05:6a20:9f8f:b0:1c6:ed27:1ff0 with SMTP id adf61e73a8af0-1c905028053mr15417890637.33.1724172216534;
        Tue, 20 Aug 2024 09:43:36 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9f8b:d2d2:8416:b9d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5ef5sm8721166b3a.140.2024.08.20.09.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:43:36 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:43:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: Patch "Input: bcm5974 - check endpoint type before starting
 traffic" has been added to the 6.1-stable tree
Message-ID: <ZsTHtWLPDvUhzIq0@google.com>
References: <20240819142508.4159199-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819142508.4159199-1-sashal@kernel.org>

On Mon, Aug 19, 2024 at 10:25:08AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     Input: bcm5974 - check endpoint type before starting traffic
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      input-bcm5974-check-endpoint-type-before-starting-tr.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop it, it was reverted.

Thanks.

-- 
Dmitry

