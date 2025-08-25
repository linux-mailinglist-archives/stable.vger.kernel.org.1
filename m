Return-Path: <stable+bounces-172876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EDBB3486B
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 19:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB3F2A6720
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBA30275F;
	Mon, 25 Aug 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyAv9TZI"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75D30276C;
	Mon, 25 Aug 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141979; cv=none; b=NIpIpcQnde6hAOkr2NybvKUpfHtz2vgiXRkA2LLRwkALuHWiVOhzDB1XGskx1ewksbeh9ftx2lQM6c6xj6B2omcXVsy3JutpEf1BmUa7CD18NtG8WgNaF0a45Lv76us3hbntT8l1GRZUuFYwbfSEXXrfP7nggMFMU8cB2E+ELRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141979; c=relaxed/simple;
	bh=xZHNKVKLd3t4a2y2+8LpNAaPdABTjrvspV304excENw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBGBVfwbUZYop2iklC+5fO3GsDLKeIkmXaRv7J3nDiZlvmD7OpAFFJX37tr72Ub0IvVQk5SFynnlFxV+zJnAF6XZitENbOjFxXXdaQ8S8AaYF6UPsh9lSJcZkorAEMqAlbLmtLZNAUjnxSHPOXeNEoqoAH+rj4UvRsw6tmIXi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyAv9TZI; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e96c5eb69b0so1157504276.3;
        Mon, 25 Aug 2025 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756141976; x=1756746776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI8ePd7/wKrk/VZQzSRc6TFVQyV9wSort1fWHyPMQ3o=;
        b=VyAv9TZIO6Y2A/VfuUUNnShSNyLTn+GsA0YMGWKgPfeSux6tX2QvwtGzG/VQQJO8cY
         hZROnofhyquVMjp+ZorCRuhE6o5lvfxyrKy93XhR+HOxbFzwGvUAXwMJis6cbH0JPOTq
         ga2qyG+AjbKbA5XiOCRR3fH92GQWNqYaJzYzqu4kWVBThqJ+9vrp9tN0TsIdkSTi2Osv
         TAb6ZWIrzsdB+lmabZSe+SJKugw+dzGdaH52HUjTVgR3L1YyE3zuWC431eBMZIuIH6E8
         bmdZhyCYQ7pvYxJ+JzqNOi48W8fqzJ6scZkjjRBz1rlhYQvjP4fWdMQBAfr4jjNp2DSG
         Dqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141976; x=1756746776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OI8ePd7/wKrk/VZQzSRc6TFVQyV9wSort1fWHyPMQ3o=;
        b=t3cWGdUi/kulNQ0Cb7L7MhHzuW8xIuD5e8WM60KVGDlgQvmenQES2sBKvIYnTnZCCY
         y+7FyfFIPHJ9La9fuiROo+u710S5osDFlv+BxHZzSQmSKilttDqFFu7dn/P8FeM1Ehrq
         0bEqNa5bZ7x3vjtcabWtuKi+E/hf5PH3vPbrko0ufElsZ7LXL7A9R2L/bkU9pA7z0Fmx
         BJGp79YjlLjFTr54Clef4xNfAZ3Xl1Wr+R9ZYcFgKCMzmJj/DTTJOPOQbAze9qA9fZKR
         Vbog8mbuasZiiPqK6C0b3AvsJfQxIisN/Klf6GxPm6ZuBXq2//6m/sju2Wtcx5CIQZGs
         U54Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXWQDlW5UNNk8llT2dTZrXkyzDh2nIrYvkkt62+o3k7lBBD0TaTOraE+oxKj72ONaC+Doxdaxt2PZnsZ0=@vger.kernel.org, AJvYcCWopabXM4k9RmEPat0yoDoDNN+2gkqg3GxFdfYXqpHcFaZkS7MNoKX23jIzxExiL8989YGTPSxV@vger.kernel.org
X-Gm-Message-State: AOJu0YzbdBl+Go9P0EjQIKWUlhUXQW+F0rZIYEwVJFx35Pi3Fw/o71oA
	REXZNq5viL602VA6gAESGffDStdvQX7SH1cqjVLqySYhwhn/cCMOd/RQ
X-Gm-Gg: ASbGncs9Kzjozu4vfgLO23PZnOTP6atfDtKZu3iOMNgnCI8lKyoBimyluFIcRdzuMAM
	Q7kpHlVMMxSFhSK08NImfkZDEhU43XYOvG57vNTLKMM/5WK3cJfBLdzLnlN9FkpzZ0DrLfO1X3W
	vms2VG2sUPWi2sjv8jw87ics7dBqtZgMvEj6havOqIdNwMNHQAU0JD3gTdqPP91JAeb5Rq9pyVE
	EnXx3wDu7ekWfFJ7DClH5p1HWunWWZccBwC9PCTnexdeooYX6plQsavwXQNHjVLwk5l7m2TNsW9
	xfh4KoZUpcEGyZzaZReTjKtzoNKBWUsvV0jfUPqhXmkvxCQA7VM3dENsslORe90JGaZs9Xop79H
	3Ra4SYtef0sRMJVxofkQOr7XrUNTJwNOeaBXkU87GtN9TfH92os/06w==
X-Google-Smtp-Source: AGHT+IEyMx/+POVFy3nvyaoGhbSSuohPwjNy61C/fbbRZEpp90mhH3T3/7m4UbJraYSe8qunKF0+Og==
X-Received: by 2002:a05:690c:60c5:b0:71c:3fde:31b6 with SMTP id 00721157ae682-71fdc3d153cmr127223487b3.34.1756141975952;
        Mon, 25 Aug 2025 10:12:55 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ffd8ef450sm14755897b3.71.2025.08.25.10.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:12:55 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: vbabka@suse.cz,
	akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	glittao@gmail.com,
	jserv@ccns.ncku.edu.tw,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when counts are equal
Date: Mon, 25 Aug 2025 10:12:52 -0700
Message-ID: <20250825171254.701321-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aKyM4jZqy8/G2DGq@visitorckw-System-Product-Name>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 00:18:42 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Hi Joshua,
> 
> On Mon, Aug 25, 2025 at 07:48:36AM -0700, Joshua Hahn wrote:
> > On Mon, 25 Aug 2025 09:34:18 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > 
> > > The comparison function cmp_loc_by_count() used for sorting stack trace
> > > locations in debugfs currently returns -1 if a->count > b->count and 1
> > > otherwise. This breaks the antisymmetry property required by sort(),
> > > because when two counts are equal, both cmp(a, b) and cmp(b, a) return
> > > 1.
> > > 
> > > This can lead to undefined or incorrect ordering results. Fix it by
> > > explicitly returning 0 when the counts are equal, ensuring that the
> > > comparison function follows the expected mathematical properties.
> > > 
> > > Fixes: 553c0369b3e1 ("mm/slub: sort debugfs output by frequency of stack traces")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > >  mm/slub.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 30003763d224..c91b3744adbc 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -7718,8 +7718,9 @@ static int cmp_loc_by_count(const void *a, const void *b, const void *data)
> > >  
> > >  	if (loc1->count > loc2->count)
> > >  		return -1;
> > > -	else
> > > +	if (loc1->count < loc2->count)
> > >  		return 1;
> > > +	return 0;
> > >  }
> > 
> > Hello Kuan-Wei,
> > 
> > This is a great catch! I was thinking that in addition to separating out the
> > == case, we can also simplify the behavior by just opting to use the
> > cmp_int macro, which is defined in the <linux/sort.h> header, which is
> > already included in mm/slub.c. For the description, we have:
> > 
> >  * Return: 1 if the left argument is greater than the right one; 0 if the
> >  * arguments are equal; -1 if the left argument is less than the right one.
> > 
> > So in this case, we can replace the entire code block above with:
> > 
> > return cmp_int(loc2->count, loc1->count);
> > 
> > or
> > 
> > return -1 * cmp_int(loc1->count, loc2->count);
> > 
> > if you prefer to keep the position of loc1 and loc2. I guess we do lose
> > some interpretability of what -1 and 1 would refer to here, but I think
> > a comment should be able to take care of that.
> > 
> > Please let me know what you think. I hope you have a great day!
> > Joshua
> 
> Thanks for the suggestion!
> If we're going with the cmp_int() macro, I personally prefer
> return cmp_int(loc2->count, loc1->count);

Makes sense with me, please feel free to add my reviewed-by tag as well!
Have a great day!
Joshua

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

