Return-Path: <stable+bounces-72662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C2D967EE4
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 07:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C111C2186A
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 05:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592554277;
	Mon,  2 Sep 2024 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPnRMzgm"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFE1AACA
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255933; cv=none; b=K978x9u4jtnbDlAlZdqZdwteGr2hzeCU7GpYqxMRGqjrqqjxXePtVn7tlP5QdjPJ0EVgitvarDo8ix2HKOfNuye+zvDPcD8dDR/1hIeayGZ+rG4NmUDdubmSOorD2qka0MAK72m56FDlmYMopEe5qzTJYg1ia/KQ63OJapnCwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255933; c=relaxed/simple;
	bh=YWFvmGdKb1M4iB9a5kH+i8O9anNfkzRTdYvQSXIWm2U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=la4Xd50xI+fB2moqKp9xMRGpyRRKHt2AmBg5MZrsCXGdhf5+RQ0ySbYuFbuQpTzKSxPr+6in+8KsdXpXnwcNYH8Jice1isi9aCPNIlTfsF4DrvgF/juz/2KkpEDOOH5E2HsODWhqhyCt8fOCJ9GsIGqrZNUd0N9v1Q9DbFmt11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPnRMzgm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso6588423e87.0
        for <stable@vger.kernel.org>; Sun, 01 Sep 2024 22:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725255929; x=1725860729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l2GxjkY66FDaLKpT12Z9iCYAURjXdkpUqitJmS3x3ig=;
        b=aPnRMzgmPDFHYLjZei1IaPFO6PoWKHJGnIs73gHQ9kUVYz5xddBgXSnRQQxmOY2WDZ
         TWRRLL25b5yHtHl+bmNiqscQj1dpQbPzCw+rNyS1Hbq24pJpyCiWmTtztrx1b6lYo0B4
         85uBCuaUBu2JtlNlKV2lF8kUvaLqOWoWV2B7ueII9GpqhZYAkBwp7fwbGIjnKNq+yPWH
         etKV5PYgoYHXE/fwFkOQL+by2DkXzNRsSUq5EXppjWwVUqIXtLiji7OvOpcDuDssKM7D
         3pWl3gewWkGCZS+BYiJPjHhc40oA+N/f0LaCCKLvIPPj/bcZ/QdOV0kFAYUvRfNmenwY
         hhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725255929; x=1725860729;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2GxjkY66FDaLKpT12Z9iCYAURjXdkpUqitJmS3x3ig=;
        b=jgP2iF++KeMQumjxz/Q6WftYwpBjz2uk1ibo3vOyYjxZ/v0kXdC0vbqC1p2zpSp4kH
         o5+oFqB1PJQoQHzuJSfykzuGyexUy/aFHqP5/ZrhtF1sBs5ka9qqtPJqusVb0Rfow3dL
         uYUIweQnHWq2z008PAhlAKG1opavHh1ZjwDD5j8gYt97CIpMiHQbRWeUwOCA62wnQ0v9
         BuGb8JzzKPHA5grZc6wpHTi9mSHwjCziQbVE56522bByxmOZwctfBMWLlAqoxqtZcdi4
         hSsBqYCZfsrAeHg084CvWnF8+qNm2rVTzuj5EFrPs6Zkul3Y1QU0RkEKefPhmyKbhEmw
         6gAA==
X-Gm-Message-State: AOJu0YzZgSL/B+2lHXfX+tI2A99DiMvu0jvhPgp18lHxbUPL4ip9SHkh
	u7CZn5xw2M8uQAb1AZxHez06fYze/KX+Edkid+F2kOjxCPjU2f3q
X-Google-Smtp-Source: AGHT+IGv3bG3GITEdzhSM4tJWGDmee12APW+G0EASWV0/DmCqw3T0/rKj0azl1FU/Ez2Cm6XIlI+Zw==
X-Received: by 2002:a05:6512:6cd:b0:52e:764b:b20d with SMTP id 2adb3069b0e04-53546b31585mr5836574e87.28.1725255928525;
        Sun, 01 Sep 2024 22:45:28 -0700 (PDT)
Received: from ?IPV6:2a00:801:2f3:776c:9b1c:15aa:8dfe:d30b? ([2a00:801:2f3:776c:9b1c:15aa:8dfe:d30b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841651sm1497058e87.206.2024.09.01.22.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 22:45:28 -0700 (PDT)
Message-ID: <348d0bbc-050e-4d3d-9956-2dc8888188f1@gmail.com>
Date: Mon, 2 Sep 2024 07:45:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH 3/9] xfs: xfs_finobt_count_blocks() walks the wrong
 btree
From: Anders Blomdell <anders.blomdell@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <dchinner@redhat.com>
References: <172437083802.56860.3620518618047728107.stgit@frogsfrogsfrogs>
 <25fab507-bf7f-446f-9ea1-cec08e9ebf1d@gmail.com>
 <2024082928-unguarded-explore-0689@gregkh>
 <d762f4e9-92fa-4e67-ba9a-2a0fd1f57047@gmail.com>
Content-Language: en-US
In-Reply-To: <d762f4e9-92fa-4e67-ba9a-2a0fd1f57047@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-08-29 18:51, Anders Blomdell wrote:
> It seems like it has not reached Linus's tree yet, but is still pending in 'https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/'
> in the branches {xfs-6.11-fixes, for-next}, where it has commit id 95179935bead.
> 
> I'll come back to you when it has reached Linus's tree.
> 
> Sorry for making premature noise.
> 
> /Anders
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=xfs-6.11-fixes&id=95179935beadccaf0f0bb461adb778731e293da4
> 
> 
> On 2024-08-29 18:17, Greg KH wrote:
>> On Thu, Aug 29, 2024 at 02:08:37PM +0200, Anders Blomdell wrote:
>>> Dave forgot to mark the original patch for stable, so after consulting with Dave, here it comes
>>>
>>> @Greg: you might want to add the patch to all versions that received 14dd46cf31f4  ("xfs: split xfs_inobt_init_cursor")
>>> (which I think is v6.9 and v6.10)
>>
>> What is the git commit id of this in Linus's tree?
  The commit in Linus's tree is 95179935bead
>>
>> thanks,
>>
>> greg k-h

