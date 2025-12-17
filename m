Return-Path: <stable+bounces-202768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 770FACC620A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 07:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71099305A100
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE39C2D0C9B;
	Wed, 17 Dec 2025 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="tg6q4QnP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC218DB2A
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951531; cv=none; b=u2Ub64LFpbG0dfIfDbV40BsQ/f2mxiczagp/M7NfNHuW4fz4TB7sIh13tuj+/02wyMjS+RGgj8Jf6x0LECx880pXDM9Ko8wtzcx7ydXeg8IkqQQXNlxRZ+geM2xiMRuqOnFFh8XEvjq8WE9isvgKqNzuaOgrTsEGYNzU+Xe0Tg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951531; c=relaxed/simple;
	bh=Ad7jbh9OQllWzVlWsfSRDDb21iSIkblF3QCWAyabS1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdI2sfUGV8VD4IfN+o4avyg2rYDdW5bF8V3+aNsFmwUYAt4muIt79wrq7m7Aiq8UpGs0PIq9QSWzW3GYD3UNuivGByRNtPRt6wRpGeRShKwc4vjxGBIms6FswOyGuiM4e8WdlE2E4prcAdpzKRYGM00qx2OCs8MdLSokbY27ut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=tg6q4QnP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bddba676613so3945026a12.2
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 22:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765951529; x=1766556329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KiR86f9NEoa8u2CiVtbJoQt39drdbuU5otJ8Ulv+zrE=;
        b=tg6q4QnP8GaOoMB/btWAovwmOEjrsVANEvkXYpjLxnRaYbvXHo8HIGfne8vViS0KZQ
         kfPOH5FeD41eyNzZuT5yGG6s75NjmfBVOANRU3JtKrsjzl9gW2KsH5wn6Co5V/wJlO0p
         XHKF+ePqWzdwMpydM+FHMJQncxtMf0Gg0/9aJ4u6qgtfiGNPqZ3tEsal5HAYxbw2HGG/
         KzrQ8Z4zQpPgu1GM5Npfua69sVODJ/1HChDnRHx2ZWOwHUxW5ypA+34ye7IUvhW3PAXh
         loQSZj9bt1RswrUydKHc5vm+KOwIJQqHmTZIUKLaSp0S2hEW/b3QTKNTZvk/O/nnuCDK
         s01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765951529; x=1766556329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiR86f9NEoa8u2CiVtbJoQt39drdbuU5otJ8Ulv+zrE=;
        b=WHZvPPy4nYiBcESc0x/hniaDtin35zQDLyJmlrAuApOcS5WBA3sZsNtfKUyAHP7PFm
         vMiDT20OYblNWvzT1mprCJ+sNEvUjmQWo9uhPop/fDbSRYDYos1F+QoNPE+CsyJ+yV7K
         Udb7j15FSzR47+rR/kQCPL7jAHdTB1fXBNCbdBnfpPCkyJdfYYAbl3hxD67B1byEAL4+
         I0BbTHNp3dVITo3BHHaVO5FW8e+SqU/Md7coTcVRcLhZ1jjrP7l0tq1X+Au7qQYmjHv9
         tPO3ElipZLqFpys1cuAoQ90nFkTDSPFD6M9DcsTK9lP3BFBpZpQYXyvg+RRToOms/og1
         WoqA==
X-Gm-Message-State: AOJu0Ywf2Ae+tPleYJKLrYqGC3r3XhBjqZsiRGltiWSRp6PECMdk7mvX
	tkupyMSi4UC17YQbdYqhe2YeZQ//EUcnOE8KN6fqcGB+9EpipqVl+bmvS61+feW2FvPoIPopCqs
	f0j9yQA==
X-Gm-Gg: AY/fxX7ozsBnrwlYuRwJeBjULTF0DiZR+9t+7ezpPIipYP/dnkEO6otkvqVXLJW5Vpx
	f32qNJWqjNSYEIsw5dNypZXtsKrvSfASHKZbQEQYkj+UOiCnw8PoD1k2E/LU0spAsN+8ne6A3kc
	eYtVLj3lzMuZH9VFK/J21GtfQJ/ZBQZgrFhsRtoTRRe1HAxADqkAhYt17rpRdMNod54JMquZTQp
	jZtjXt90bLo3d2Ze6fek6AGtSi59iXfBmgu5so+VxiOrsVomQrOc17o/5aZRxnD6Hnsy2D1pnBG
	ekW4c1Aym7tXRKjGjqB+96lT5UO1VrcD9mstpnVQjjBhrkpPFqfuFyYx7YTRI2ESKzrzNa7HLV9
	wox7FDEBq4xfcS2v0XwOR0k26wG2FKi+/cDQYQh9QKsgvwHjnCLMK5KQfRbJkKarBjdNK8jTapF
	wadTT1N2sBCVh94f+BpQgwM7Us2ZJm7yBJVoXPKgzNOCE=
X-Google-Smtp-Source: AGHT+IFpaLpwpmMAyJ8lx6LOfcUfhHVxCcXUNqCAf/QcneB9oI0byP2Sg1xC7/TQYNjWzXw0V9xhBQ==
X-Received: by 2002:a05:7022:3a8e:b0:11a:44d1:533a with SMTP id a92af1059eb24-11f349c54ddmr13362634c88.12.1765951529487;
        Tue, 16 Dec 2025 22:05:29 -0800 (PST)
Received: from gmail.com (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f446460c8sm22914800c88.10.2025.12.16.22.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 22:05:29 -0800 (PST)
Date: Tue, 16 Dec 2025 23:05:27 -0700
From: Will Rosenberg <whrosenb@asu.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Oliver Rosenberg <olrose55@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 240/354] kernfs: fix memory leak of kernfs_iattrs in
 __kernfs_new_node
Message-ID: <aUJIJ6QFNDSk8trU@gmail.com>
References: <20251216111320.896758933@linuxfoundation.org>
 <20251216111329.608256836@linuxfoundation.org>
 <aUGN6G0v6bi8joVR@gmail.com>
 <2025121740-utility-transform-f252@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025121740-utility-transform-f252@gregkh>

On Wed, Dec 17, 2025 at 06:17:24AM +0100, Greg Kroah-Hartman wrote:
> Please don't use lkml.org, we don't control it and it often goes down.
> Please use lore.kernel.org instead.
> 
> Also, this was totally context-less, what do you want me to do here?
> Drop this?  change this?  Wait?  Something else?

Sorry about that, here is the link from lore.kernel.org:

https://lore.kernel.org/all/20251217060107.4171558-1-whrosenb@asu.edu/

This patch should be dropped (or replaced). The patch is faulty and
introduces a new bug, as discussed in the link above. The patch
should also be droped for 6.6-stable, 6.17-stable, and 6.18-stable.

