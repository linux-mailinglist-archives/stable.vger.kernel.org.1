Return-Path: <stable+bounces-194475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DAFC4DF38
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2CC18C531D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEBC33122E;
	Tue, 11 Nov 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOk5nSJo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A824324705
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865274; cv=none; b=GFifNHckwTiim8CuR8UOqAKLqyvd1FXJSXA7ymOyIjRQOrvVavyQ5gdOz9h8CyhirE6xAShOwxLH8vjmx7Y+I2//S+HFHtj17h9TBaGRAGpQexg4SeGucRWSgGpqJJz+V9o5ByY8rOLqhnDBbL1g2mrZMYv8jjosZpKBpPtZ6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865274; c=relaxed/simple;
	bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWwnVlj9jHfsaPXhXfOk2y4cjzgijBzO8Kfp+87RL2jSx8wc5wfVsoinGI151vzCge0uPSTiFO5jGjzXxyD1bCoaOZBLpHaQNfrXkQwvwDGOdl0Cuj87rbhJWGa4EdZT9xhcqHU9d4QYtn8BjqvtzPWAju1QF9ym6+ELnvD4o8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOk5nSJo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so691833366b.3
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 04:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762865271; x=1763470071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
        b=FOk5nSJoQjCABGf/sAQ/B20xKRrjjzuVFux5FDtYHfJmC+xnmTh1dtMrDF6UeAR/WF
         BiK82c2sdHROsJ2oUWIM2cnG834hTGNhcXCn2F9sGchGrHU+wRVf/quAtsAW317w4Spv
         pzJDBy2ejovyN95vUNSUgWanj5LCIRhY8Mq1NJ1FuwEkbLgIezViO0BOhf2X408j5JhE
         YujDkfwwt24qTzOOHp4+voMv6LXJtJJ13MNIPDLU2XuhmNj1XBFn+33p9XRzLjgrfos3
         HtKfPZkjX+I6v4YzutV5f27+cKn/jjUAcGjpOgmd7OLaZUtmHBNVEaqhppYeZXC/B8fE
         mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865271; x=1763470071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
        b=GK5WfBvowZIN22qlNjKkrw4SRd8Sg4jJRlbVw4WuUMRukYhWzWl5YPVf0mBzjYKwwp
         xD0yq1Htyb9mdVUh71eUaLhO6MPZ4PZe/X5HTkADS8wcAOhfZcKUIxY4u2G07yhL2VRp
         X0rIlXihisLDqlQqcI0rKhoy3k4CGA3GCCEFEe97FvwQiV4JReUCYqGN7LcYmY26nQQp
         bgBVjI/erUjrp3kLHKPtsW7BvM8mpcgwYcUt/z/auAe0Jmvb45WR3YyTlYg9ZUyPO3AR
         A0JiVboifUhSrI1/H8gTWZq2ppAo07zH84SM86++BZ8PDKsHph8fIRpzucrsOUF7ogou
         iZXw==
X-Forwarded-Encrypted: i=1; AJvYcCU1X6e4njJL7vMdgoU7o+ehMLkwOC0JZpHtsk26r0I89n8kmN9sI/unPBplp4h+Ph1RMxPj63o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxu0cFrUP5LrlfyjQPaFiBRp19uR1U7577nmOFLBCA0mC/GHO
	cWBN2VxGzNcZrfKNSp2R1wecd61aiA2ztO4khSPdIH939/tv4ioq8fwJ8lU4RUTtryHXzNIUjbj
	TAY6JkZwRjI3VZCgwZ+v4XY9Vo115KuU=
X-Gm-Gg: ASbGncvgvPwZBaf84dhonTmlJ46OEcjUCqdx9go0+isQ4IYX+r8s3CDO3XrbEw/4Jr7
	MIWWo8LtuIxD/ldWDTEqIMTysxuD7q5JEtuLK1x+yItwSC+us5DMGe+9e05lLeBDD3OBJQc9le3
	oDQb4w+O+k2oWyu2+WiXgAdjl/1NXdrIQ910B1LsKt7U/YDkTv31YynTATJdT6wMy7fEbDBYawr
	EabPMm8N01vg4qKUqGQd/ibgEOh0f+Nv63cB5ex5TYoqaRSvA4xQkxYLhE9
X-Google-Smtp-Source: AGHT+IGiAQgwMVRiGCnMiDWwUKJTp3VVUil3hi7anG6LPGbxJTxQiXv+QsMmKl7eVBT6UKFdaroeoqA7jwP8sNFm9RI=
X-Received: by 2002:a17:907:96a6:b0:b65:b9fb:e4a7 with SMTP id
 a640c23a62f3a-b72e02b337fmr1061707966b.9.1762865270901; Tue, 11 Nov 2025
 04:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122023745.584995-1-2045gemini@gmail.com> <20250123071201.3d38d8f6@kernel.org>
 <CAOPYjvbqkDwMt-PdUOhQXQtZEBvryCjyQ3O1=TNtwrYWdhzb2g@mail.gmail.com>
In-Reply-To: <CAOPYjvbqkDwMt-PdUOhQXQtZEBvryCjyQ3O1=TNtwrYWdhzb2g@mail.gmail.com>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Tue, 11 Nov 2025 20:47:14 +0800
X-Gm-Features: AWmQ_bl7jKmbrVcAN8OrZV0RsO9xo9Mq7861gNjqd0U45fWXiyojg8RitqkJLAo
Message-ID: <CAOPYjvbEbrU6qOewg4Ddc8CBDjmXous=PbgFF+5cQHf98Jtftw@mail.gmail.com>
Subject: Re: [PATCH v2] atm/fore200e: Fix possible data race in fore200e_open()
To: Jakub Kicinski <kuba@kernel.org>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	horms@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub and Simon,

I was organizing my emails and noticed this v2 patch from January.
Simon kindly provided a "Reviewed-by" tag for it.

It seems this patch may have been overlooked and was not merged.
I checked the current upstream tree, and the data race in
fore200e_open() (accessing fore200e->available_cell_rate
without the rate_mtx lock in the error path) still exists.

Could you please take another look and consider this patch for merging?

Thank you,
Gui-Dong Han

