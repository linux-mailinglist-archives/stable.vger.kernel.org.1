Return-Path: <stable+bounces-124042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771A6A5CA82
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B715A163F1F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7F25F782;
	Tue, 11 Mar 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbXK5deM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4325B69D
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709616; cv=none; b=usJPqatcE1i6tKsUF18NLNpdiB1jn1aR14acZ8xY1lpo0SLnqTDTMOKS2yUeqeMNgEW+1VllLD1oBhiJaqiQXKj+++PRmZAeEIJELG4a2ciwE4mUCC557hFQpkDy4SEZ5LRoXWRCUgR0Lm6UfweHHTGhV7E361vZlvUxVWC4j4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709616; c=relaxed/simple;
	bh=9tsGxAx3gIALlZ1E8ri0rwyd9bu1oEuHeuwa1xtNz2Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myfp6UNOTdAEdHCMEw7h9zwsnAx3pewGTjNKxXqpMJavOyboLJv6fMkpWpyAV586nu3kZZnevcjnw3Rvlt+31RlaaliIOwDWhjRd4P5OlL/m2RWxozP/ELYhd/67XNaBZ0GBeEQadVuwi3rceuXE9U/IPyP+VjxhjyvsG5/x7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbXK5deM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307bc125e2eso62981191fa.3
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741709612; x=1742314412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLjd8/m6hGkFtHjPWUtrhiu2MZm8JYFQQXClX3vRW2M=;
        b=HbXK5deMh5rbnQnqQysoh6C4UkO44Nqr77XgXJZtEvI2JANitWvsueO8hqboOyuB/V
         l8HVwPcmdVlXTlcl5qHeTR6umrYNRJP60R3jybQxJkVO24N59tOosJAx8IjGQ8wtLqes
         d+WGmjq64HdSbV2IsNmeu92HlYn9ppKOJfu16ptbASzoqaplIrMJ/q6cIcpLC8Objls/
         ZLVUy9dHZFTQAoqML7jOP6FLP26uv6Wkq4NZGiaeYqy+yyvs/IXrBvN9vJwCBG4fM27K
         tQs57kufU6WDJeQngMi6gJl1Sb8Xf3hOT1OtfvWym09T8uX7/p/22iXqAmOziBoBcXzp
         gdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709612; x=1742314412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLjd8/m6hGkFtHjPWUtrhiu2MZm8JYFQQXClX3vRW2M=;
        b=hFzPukclKoVrJbUhw5MNxEDdiJ14G5SukOovHewIpNZOF0iBJbuDD42vx0zUdMBmZn
         FEz4vSXyrtDs7da73b4lNrlEoENSxDdK0sEWUJBah65QbZiptMX0WTptWG3cMLMBUOrO
         Hp/9qdKuEAO54qHWedReinwyD/LmDo0ILOWEAB/y4HmEjltrt/dlvcGegrLP4z+SG2W/
         BwBi8oU+vm3Dj5KSEH1Jq19WQ5QBPjXcGGJK7clp4cjj4jIxTHsasGjjcOxqVfj7hh1R
         XlGM1j/MmJVJz9O5pb9yEwbRHyW73+LDTwkKgPqqimq2TXt39E/mVs46QbC9iDyGZUsx
         UFxg==
X-Forwarded-Encrypted: i=1; AJvYcCXfhro3iIMkTm4FLSjs5YdBCJFzGMbHsAV2WbZPQPnryn0G/ba0E57b3BykeSdsIRty6rYopWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWQWfDuMHOVSom+KYiTfi/a78njxiff8BC9a0P7MFOe51D0Oi
	jy1vKeI0W1rvgvjVC9lg0TyGCmJ8o21Vi7St//tzE2FND4mlqz0B
X-Gm-Gg: ASbGncsxdsLMjL7FLgx2UlkU3izd4OXmZwu+a5LRbg1L9UpnIeSW/vzrkLoGeTiSO4W
	vsMiYXgKBFe9cgDFN5GVGmYAD3gTHZJ5yqEmM/AUPbMa7hOzkC9K1qqxDlkElv9eLVwq3ZnYXYl
	XfCxRPEP8vA+qCjl/xbLvz9wdQeZlrU3QU+ykjOVW75sOY0sHE6VwpgNEAGNNW6Hc1VejtdAwiO
	DTYHSdddZ2+XREKgJbG67z85u4VmtOdCYzwGRWT7V1yIZ7QI/yIg5HCXoHQe6vDMTHn95sMoUUE
	W8SkzdimxfuVOnA6YoawoTqpdRfxQI2Jl1JpzoV0qOJBp4xnwi/KBUQkAgWlywR0eJI=
X-Google-Smtp-Source: AGHT+IEPa+4O+iFdZTWCWxrddbGjRmmNRNeVrtS2wfjsN8Ex9YyS3sh6HnuMeK7GmASYtgxmijUsRw==
X-Received: by 2002:ac2:4211:0:b0:549:b0f3:43a1 with SMTP id 2adb3069b0e04-549b0f34530mr275216e87.30.1741709612011;
        Tue, 11 Mar 2025 09:13:32 -0700 (PDT)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bf351sm1818651e87.175.2025.03.11.09.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:13:31 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 11 Mar 2025 17:13:29 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: gregkh@linuxfoundation.org, urezki@gmail.com, joelagnelf@nvidia.com,
	kbusch@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/slab/kvfree_rcu: Switch to
 WQ_MEM_RECLAIM wq" failed to apply to 6.12-stable tree
Message-ID: <Z9BhKRNXnI8uL57I@pc636>
References: <2025030914-turtle-tattered-27c6@gregkh>
 <5ba8803f-4208-4f84-b24c-ea2cc8539849@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba8803f-4208-4f84-b24c-ea2cc8539849@suse.cz>

On Tue, Mar 11, 2025 at 05:11:44PM +0100, Vlastimil Babka wrote:
> On 3/9/25 7:16 PM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Must be the code move from rcu to slab. Ulad, will you handle this, or
> should I? Thanks.
> 
I will handle this.

--
Uladzislau Rezki

