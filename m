Return-Path: <stable+bounces-114916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE29A30DB2
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605A2164D87
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CCB24C68A;
	Tue, 11 Feb 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3d4FeV6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067A1E32CD
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282640; cv=none; b=R9RzEAWPTgH6JTFBwQMjFJMCTAA3A28POK9iELr7QfodEp1lgJKxNCCIaG1FQvAVQ2lrAos+Mn13VT6JogwzLvB30RtfI+wRk1/3+Ok3PUtQmLhuhR8G8iGAk+FqVerlVu0AJzv3l4r2tKOr3q5fgGlrXmv83J/nC0b4N3j24rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282640; c=relaxed/simple;
	bh=X17TXf8wif+MWQ4x5LfqhMFcPbQrGO29Av5dMl92mlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CST8zW11zhx2RkJF3vyTKWoTiUTVB2gNs9oIVHlYned75dtdZI5HSTMU8jXfZsU/X3qft8SqLM9htz+476/xlvdROw/o/rLkurzm1y0ohah1T1GxEP16ddnwxhvHDAYvnl/lO1mYSgVlWXdEpJsDvl2c1+yKDBkBpV3HFog6sbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3d4FeV6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7e1286126so127784166b.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739282637; x=1739887437; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pabNrXU0xE0waiFL6q/HAjhJBxDTQFT1AifQjj75n8Q=;
        b=Y3d4FeV6TBS3EL3IvENP5ivI/2upPTLegGhND7+XuFpXfAPiM8JgMRetoKFwLQRztL
         QGxsfJZocM42IEJ77xHIe/in9JIdCcX7F+XiL34Lm0ZsMgDU1YnmG6aYii0rzjc7c2N+
         2QlH5hb6cjH5WhIscmHqGzANbWr5hheSdFPNHaMFymQzI3riWW5SxFAaeYHl+/QLptRD
         FBVstyAo62FDXU+OsMyPokvqabEPZ9vPmDdA+JFXzkL+5see+mMAabLKwjldZmeKDQNL
         YFQVNrR01+h9VHvnKN51l2mgbGGahnHZb5SgLIiNBxL8YJ68gzxifJA3w3uCVYzYCjup
         sOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739282637; x=1739887437;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pabNrXU0xE0waiFL6q/HAjhJBxDTQFT1AifQjj75n8Q=;
        b=Wn792O1oyndaAD7HGiKz/J5dJby2wG9ZW61Nw6KmxKcOxcah965wAjKgAQXkmZ/wfV
         7qjPJsS+x5G6dztwm7374fsIghxjcBwXwDvGl5qKPiSn6K57o13itHaG3XctuezqMqrX
         EqPuK5dluzTUEvtKZaTp4P+Wry0Kf5/WTQqSo8qZ5Yurk//QKiPbyoQMGpBsNlZAmV2T
         K6DGJyCKgZZaAYQdoB7dg7z1Pp5p2zzue4K95dXFAGEB8xJGipC9LgbsPMr4cBmsDHNa
         K04MYUYbFDjhWHpXFtcbKh7J8V/lYYDAUdegyU4smXq7nZx854aJgXnRD5biBELuVYrK
         6kLg==
X-Forwarded-Encrypted: i=1; AJvYcCVC6lxZ4CCtPwv32zaalTMB3l8xlbEzuH0vF3ucid8X1+RJvvpftgzjWY0ZMs/qAEyYNsNVKO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpI3QDQ+CB9IGPHzoHf4rAHp8BYFg3ZJdIgPz509L2bIB/urnw
	9BmgnVj3ni0y5YkbggIcRLWDfgLZtmC9mH9Xq4/TYmdsPYjXhZiKicyD21Dg
X-Gm-Gg: ASbGncuVfrZAi69HLSzHEyklItc4PtO1iHj2+g8hMjug2rQZlHz7lEydVIt5gj+qrp3
	VTqsVLsvmk3Vs3VzNZgWNy7MjfdQP2JIOnZFQ1hqgZFaig4iohVXIS7Lyd1vdjB27v1inOLhxHx
	YV43cN6kSzMS72JRJWyM61cwiMa7VI9XcDNWFHY4GWSTri1bV+9w3hYVv3fTQSljMcDgKxeTLty
	YCbYrqHHah6sMWlHFknvDYLGGY9ZXuGpcjUv33zdzV49EDgCU1lGHTzienHqOHUzqosNcJWv86z
	V/wT6a17ZlFwbVw=
X-Google-Smtp-Source: AGHT+IHaqPP5TQ/Xr/nchekh0ItdeKKKBRq3wOlZaMavCBoW+EcVUT+OfwLOAAq9HGKvVepVuUFLnQ==
X-Received: by 2002:a17:907:7ea7:b0:ab7:8079:78ae with SMTP id a640c23a62f3a-ab789c629e8mr1583131966b.44.1739282636583;
        Tue, 11 Feb 2025 06:03:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7dbfb2c41sm161238266b.13.2025.02.11.06.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2025 06:03:55 -0800 (PST)
Date: Tue, 11 Feb 2025 14:03:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: gregkh@linuxfoundation.org
Cc: richard.weiyang@gmail.com, Liam.Howlett@Oracle.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	sidhartha.kumar@oracle.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] maple_tree: simplify split calculation"
 failed to apply to 6.1-stable tree
Message-ID: <20250211140354.zaqzoa3b5xc77p27@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <2025021128-repeater-percolate-6131@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021128-repeater-percolate-6131@gregkh>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Feb 11, 2025 at 10:48:28AM +0100, gregkh@linuxfoundation.org wrote:
>
>The patch below does not apply to the 6.1-stable tree.
>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger.kernel.org>.
>
>To reproduce the conflict and resubmit, you may use the following commands:
>
>git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
>git checkout FETCH_HEAD
>git cherry-pick -x 4f6a6bed0bfef4b966f076f33eb4f5547226056a
># <resolve conflicts, build, test, etc.>
>git commit -s
>git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021128-repeater-percolate-6131@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
>Possible dependencies:
>

Hi, Greg

commit 5729e06c819184b7ba40869c1ad53e1a463040b2
Author: Liam R. Howlett <Liam.Howlett@oracle.com>
Date:   Thu May 18 10:55:10 2023 -0400

    maple_tree: fix static analyser cppcheck issue

This commit reorder the comparison and leads to the conflict.

If you pick up this one first and then pick up 4f6a6bed0bfef4b966f0, there is
no complain.

What do I suppose to do? Re-send these two patches? or merge then into one?

>
>
>thanks,
>
>greg k-h

-- 
Wei Yang
Help you, Help me

