Return-Path: <stable+bounces-135136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA25A96E03
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C3844031E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1BA2820D7;
	Tue, 22 Apr 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="imTpzt9Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B5280CFC
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331031; cv=none; b=P/NOWsNT4CmDgnBIuZDrkIA+RK/dFk11+VEJGXOaTJjnMHcBrvpyPq66ywYpFTjocDP7wtI2dMUEDVMJ89CKYOdSndrxFpKbJurjNTHqt0/uYxJ9nxTjXPdVlLS3Edb2rDbv4eNgYvN+WZA3FOroGgeBWwUUghfiFigaY2+n6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331031; c=relaxed/simple;
	bh=b/gVz6vPrdrPYm9/UTv/wEDNkO8+UGh0Z5nYBx/1Bgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kA20fpD7kid4GqXGul6nY734eDNF6VxttK2jDpE6t8+8QKxESSls+Gi/PkzeAEzj76AFOfbFByMPDErNhLuvMY4hWaVzji7LxEFOzpUf73gHUD9gSwdxZRfLPm+6HDB8JhNkXIFTqcwQlJKsTO7CPJIgQYpeHh5ZLutwK6u75BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=imTpzt9Y; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c2504fa876so1328324fac.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1745331029; x=1745935829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b/gVz6vPrdrPYm9/UTv/wEDNkO8+UGh0Z5nYBx/1Bgo=;
        b=imTpzt9YToq1w928fsWkJRZ2t3zJ0ZEuQgGKbmHhic++NTBc0w6iMxlv6L2+/x8MMW
         5LJkMqAJdRQlkis4N9iDYV/JdDS5oRygZIQwMLZyZHXGvK9gxxQ5oTHnvtPgg2zPcrbY
         6JZCPUWG8GTw6nuqLn3wdF8yvldIbD524PGR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331029; x=1745935829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/gVz6vPrdrPYm9/UTv/wEDNkO8+UGh0Z5nYBx/1Bgo=;
        b=Td+W4cOG/pE8BPWdqes0hgQA3ka08hc0J8aHEIx5t/1O+KZXmL8s9eJNSfThIAPiAN
         vtGUZm9cHVEtxbxYIzwURBsaMJNGo/EVblScMw13nqtk1pWGSmlk5gh6ay2PpSfwkk1J
         5vcBu9ddd+eO56wb029xldwwnPYbM8xEzLdZla8mQV+HxXOU84JC70ICD0N9Or+Bb2EP
         O9glPMt4dXMi92NpYKJ5gPtt+tnbGq+uYxTL3iBO+YFYBj0oFAeWZ95NVcTlvMiGo3z/
         vsoPd7IE0u5VL2Y8YtPCWvo+NiGnMsA/brNWTvsfPGpRTgr4rnyzBt7FKybkIsC/FQFQ
         hEQQ==
X-Gm-Message-State: AOJu0YzC9dALXrbbYqAwn0M2E2qqdFIT+6YpZFzWYzelRN7x/rKMPT1N
	f7zQruZco6QJ+4Mgw0EmRQ+k5fnufG0PUKmjWdKtZqVhlaX0fnVaWk7Rkh64ryJ7ykDhkhAISiM
	LGI4D28ZQOZhk97aACv5ygYTLEFqKAJJspZsDpIIqAc6fiADXtjm1kg==
X-Gm-Gg: ASbGncs2i9OE/1vSnEQE4kpM8RnuQUpobviNuJ+ykZX7ccJvBUMDeE8L+YqfHHIXBBa
	RzAnORjx2XsuCNCLVpqjRtfwL3Q1p5E9atrn9qdUAVlA0M1rVP8Q9ReFq0QxCMZ/lNn5b2YswjN
	dmsB1+UdvDWRgph9cxymWNpU0vCPSQNcEfjqXbyYK8AYbFLeWbmPgYJg==
X-Google-Smtp-Source: AGHT+IFYI2OQCxwukyzD8XgWvqVnPCSGoJO8iuCDasWbXtgmbxh0uhQlufLAfHWGVGAjQzyI+K2dIlsvE1S6qIINQXM=
X-Received: by 2002:a05:6870:e60c:b0:2d5:230f:b34a with SMTP id
 586e51a60fabf-2d5269d5c4amr10362625fac.9.1745331028814; Tue, 22 Apr 2025
 07:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416064325.1979211-1-hgohil@mvista.com> <2025042246-hush-viable-35fa@gregkh>
 <CAH+zgeHyLBNMz=kWw0xbfKfw2Fy6BtbWZAub6w_cTsAhNEsxSw@mail.gmail.com>
In-Reply-To: <CAH+zgeHyLBNMz=kWw0xbfKfw2Fy6BtbWZAub6w_cTsAhNEsxSw@mail.gmail.com>
From: Hardik Gohil <hgohil@mvista.com>
Date: Tue, 22 Apr 2025 19:40:17 +0530
X-Gm-Features: ATxdqUHdBkCQ8C2slolF3s4lzLbiM3gmmQFsIqRPD57-YrJKZQ2nBPjG216v8aA
Message-ID: <CAH+zgeEt4vqvF9KbTxZzhP2+y3g0evEWb3kh7YOKNBL6rs-OXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling
 reserved channels
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> > I'm sorry, I have no idea what to do here
> >
please add all the patches 1/3,2/3 and 3/3 to v5.4.y.

