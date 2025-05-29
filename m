Return-Path: <stable+bounces-148120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BC2AC83C1
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 23:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9C1669EE
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D885A29347F;
	Thu, 29 May 2025 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgW/oZdA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC5227BAD
	for <stable@vger.kernel.org>; Thu, 29 May 2025 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555862; cv=none; b=ifctOl4vNZizC1P4cMZ5DEOqsaSORx70HXtWRQHfpJupP1RKvR2AYfMcrTI35BK1A7Cd7sTsFiBw7tZ0ODSawgJ3Oi1rVZZMhM7eFGdrqj9cmL7YqBK/JT2Sl+g9ZjTTBfLRSRabqy5cSaWsHqAK8msmH340R5nAFHJ6xxqd1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555862; c=relaxed/simple;
	bh=hRhuj7xE1dBPPnx/EVxIJiotQ89zyqzhXVw7IFjGmE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgNCEntm8ofefnvrNn2028H+9ae7k+fC6h4TIIj41D02xDIb3QBTpxilVryl/+TSAbYkNyl4Kxe6ajkAJnA5ltXriRX8e6QH+jP829qPgZFdMyNUM7wco9mDDsYMzfZwaeESFyYUsijr13iK7bcPzmxAwYnYQL6M4G4GAKk5+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgW/oZdA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e09f57ed4so23063435ad.0
        for <stable@vger.kernel.org>; Thu, 29 May 2025 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748555860; x=1749160660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x0GMs9CYxQo1qYKiYb5d9sx6J+FnaGgIltFASAatpr4=;
        b=OgW/oZdA/xF2+Cb4BuA55NZzrwrK6k4JLlW2MWWnzF1mXkNAvepYevHr0romStjr2q
         6woVmIbMNM7HGBkM6YoWo/IvBURljnA607Gypx4YnpsTFXoFsKfa0PB8IXVwVq47+iKF
         Fdo6pUvTjYqonphBimS/78/ZN+uZzZj6i6DjpIOUj6W4sbGFU5GgdmBKJJ1n52rhZE8y
         wNjnW2TgZnIfPC+1AcTAVZPRPgzHf842J77cMVIp2hoMDiZMRRYerzqWcE5F2GaUBz4M
         ODfkoqDWDF4FynPqfTeC5Y11owartmSJ6oMaaHt5HWR0Ji76kBDWrvgjL1ipKeg0shuD
         qOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748555860; x=1749160660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0GMs9CYxQo1qYKiYb5d9sx6J+FnaGgIltFASAatpr4=;
        b=XUqofOZ71tliVFdav7St2bukZZp8B9bAmPG0f/HGimtXkAB+HDZACbxbtYrIfEFuVj
         AKn16pnUWRa1LXviIovWFlhnQEhqSdfFOJs7QH8aiYPg78LawOM/xuQOm2wwUCi8sNAR
         UAQbkeEZCU3jJ5Wwwn9WV2feRkt2MiuwvdwsilVnu62yFVFHo/q0x59mwIG4cLXgKgFx
         NEv8WJ0QTQtYvQXaTmxOD1AUq0R692/pt23pJcE/U5d0cxIji5WLltahwW7eaydULZXT
         JzGq1zHyIo1Is4Ap/j8pfXDRY4R4fvSoYJDFG/K3NCJd5Ew7QoSxnxS9K8EyeepM0APd
         7G3A==
X-Gm-Message-State: AOJu0YznM2KkZg9D7iZASGqS1uOzRIFQX8OoXts9p+/yAmgFDgJwWxgh
	sDYILXRjP10RV5DOAamZ/bN/zMKcI2sPSJ2v8/sIEsndqAKrQifUKLvn
X-Gm-Gg: ASbGncs1xkasBXRfiCKGUXjrjDpgANj4E43x18rySJ1hzDMLeUURgXqyDeDTi1mZZ1V
	lr2X3KwEt51Sz4D/CQTwbRZkOb1uZPUaX/nGgdOLJt3fN/ZaWLauMWYN5Pith6KwF5wOTVH4kQy
	jzkOMd5OjxmxSfqrzXCuwT6643N+6KZDckxdEBCf/HKlI5UJ8KdkFEk5wFWfpiPdfA1NXz5ZZTm
	9Xs3PTA2zYTKjXjmT5ghnupO2wZ9VO2SDCa9IQ6SifQdcwpuQ4nSbyuWDf1iU4eejdpZhFbY69R
	c61XxJ6vAgeCF3+uRwudXqQgF64uLy5y9awMQFJGm2vHWgWYP8r/Im4JbTwOZmw=
X-Google-Smtp-Source: AGHT+IFCgSmz/OIAP9QcUueti/TFiI+FoURwz75jbYsNGy7OOgBeFcGvWYnDLiQ58WZGcXzehIbEvw==
X-Received: by 2002:a17:902:e803:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-2352af0b270mr13215645ad.2.1748555860392;
        Thu, 29 May 2025 14:57:40 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4497:aae1:cfdf:dc31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14c9asm16655905ad.231.2025.05.29.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 14:57:40 -0700 (PDT)
Date: Thu, 29 May 2025 14:57:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Subject: Re: [PATCH 6.14 750/783] Input: synaptics-rmi - fix crash with
 unsupported versions of F34
Message-ID: <mznd6ptvrkapnt2tra63bsavlzr6iuicd5o4re32vrtye5au6w@5q4b22g3oszc>
References: <20250527162513.035720581@linuxfoundation.org>
 <20250527162543.672934881@linuxfoundation.org>
 <i7tnbh7l2blxussxcdgjuvcpkzet5w552dqu6vl5upus4xf74n@dva72me3bdia>
 <2025052959-corrode-outback-6ecd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025052959-corrode-outback-6ecd@gregkh>

On Thu, May 29, 2025 at 08:35:17AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 27, 2025 at 01:42:39PM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> > 
> > On Tue, May 27, 2025 at 06:29:07PM +0200, Greg Kroah-Hartman wrote:
> > > 6.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > Can you hold this for a bit? I might need to revert this.
> 
> Now dropped from all stable queues.  Let us know when you want this
> added back.

Thank you. It looks like it was a false alarm, but I'll wait a few more
days just to make sure.

-- 
Dmitry

