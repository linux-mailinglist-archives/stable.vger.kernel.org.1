Return-Path: <stable+bounces-59250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15068930AAF
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954F81F21394
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E895313AA2A;
	Sun, 14 Jul 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASuTbS0Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6526AD3;
	Sun, 14 Jul 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720973129; cv=none; b=Q3fUuhs2kzgatKtvBPBxTq5OROgG2z1bul2sGzROr/tzMt5Db7n80ZOkMwEbMi/+Ej4jCYaznV0NUh+C7mVNuvfenylGmW/6p256gQZyPlzQzA+Q2geUpofuDCcxkqeiwVkaXAnOXt9ZJL50xbEAR2kyUzxi4kkT/x15dCCEVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720973129; c=relaxed/simple;
	bh=BThKgLOyiZs0ED0qNul/PfREiwkcu0W/YUKGklz/5DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW0G0EgwkBbhWJ77ns06Q02k20RTdWF8cWUdW9pmK6nMFohrwEiLwnNLXYwT5ROzdGj0r2MW+661onV0oJUMwbb62nPUKlXfzaU1HKC+NHqrx2NXIHKhJdn2uDRXx28nefQH8U7HU7shHMGajjnUIPwSoBS30B4cpR9Lpp+vsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASuTbS0Q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5957040e32aso2265295a12.2;
        Sun, 14 Jul 2024 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720973126; x=1721577926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzsOW3jPrt4WczAvScEktJZjwhVKZi7MkvjsHuWYwOI=;
        b=ASuTbS0QwFNha+xcEsLW3f4sC6pHP2CR5cbICoVyw2eKXSg7/g0zix8QFDNcsDIEvv
         g8aleYCUSlrjnLLJsD/kAMaCk/Ss8PYHURG+1O82z4Ac0jbatVpoU0R6Hdx5Y5/G1xMn
         /neTIaOCVeUqG8HD9QXXgZbU/P0LHcpzgxal+MStC1KyrXvO8hM9ewVVRgrL3HbZA2ct
         uUf2jbSelk3KG7dIEa7lWNB7dc12UxbLTaaqybfRoP26pryv38rRZobsd9o7gOBvBK0K
         9TBlA+QW7TjekneoHHuNZpqzjZTiIe62n4FpLRRA+NAS0uSMPWgZXNwa1Xie0TnSunTo
         aBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720973126; x=1721577926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzsOW3jPrt4WczAvScEktJZjwhVKZi7MkvjsHuWYwOI=;
        b=TYesjwld/WhalMzWDv/KQ6LYAKghuyHXEcpLc4bRaaj6T71gvWy0tVtpJNnufLreZF
         KQ62Og2oNOuISZTJ6udqQRdfmh2ARf/HSD9EYCBBxIQTrKuQB58xg8aBDumJ7+wHeYkS
         9SWnj/ELMPQQbSoy+InOFl0dd+91kn2cc9Q67rNP2PKbMF/+GHCCy8gcxFWb5b8RFnhP
         aeiNXJ6mH9eaIW7Nce7vVR2O4n5f9cGNEJpVBwqxRqIA2N5dWhGC/UDf0rajNo3ql3vc
         X+M5J0Yciqg8XL7MJ08pIrDlLTJ9Haudj2Eey3z8rc7pmLa7WpdQgXRnpspMtauyaf85
         UBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWEnF29ce3p0KdYEyq77uucQE9vPxau8wu1UO9K8cJGYr4owoQ2+cQ7CQglPMNV0u7xVYWsxoWfYOTE8JE3qWQxP14SnDGDfJ+neC/ewLEOV67qg5oThnAKWApKfP5Q29ODFU6kyag168va186oO6ePqXG+bnMbTZFUBvQC70t
X-Gm-Message-State: AOJu0YxCN3mQD7+eFGM6lMqTfX7DU6j8zb4pD5eZvERiZw/Tx9RfDw0Y
	kTT5s9pi4C8ZoGsKh1rBh/Ctnpo9yO2oqc5bRW8ih7Y2EnFhZ6Iq
X-Google-Smtp-Source: AGHT+IE0HZvjsq7HBzHlKX6FbekQ5XaoHXqLiwC3jNlpB+voSFxqC7aMQAWXjZQzIO5j1pfzY67A1g==
X-Received: by 2002:a05:6402:1eca:b0:57c:5d4a:4122 with SMTP id 4fb4d7f45d1cf-594bac74fbemr14077949a12.9.1720973126324;
        Sun, 14 Jul 2024 09:05:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255275bcsm2206984a12.48.2024.07.14.09.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 09:05:25 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0BF49BE2EE8; Sun, 14 Jul 2024 18:05:25 +0200 (CEST)
Date: Sun, 14 Jul 2024 18:05:25 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: elatllat@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mathias.nyman@linux.intel.com, niklas.neronin@linux.intel.com,
	stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
Message-ID: <ZpP3RU-MKb4pMmZH@eldamar.lan>
References: <CA+3zgmsCgQs_LVV6fOwu3v2t_Vd=C3Wrv9QrbNpsmMq4RD=ZoQ@mail.gmail.com>
 <20240714173043.668756e4@foxbook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240714173043.668756e4@foxbook>

Hi,

On Sun, Jul 14, 2024 at 05:32:39PM +0200, Michał Pecio wrote:
> This looks like bug 219039, please see if my suggested solution works.
> 
> The upstream commit is correct, because the call to inc_deq() has been
> moved outside handle_tx_event() so there is no longer this critical
> difference between doing 'goto cleanup' and 'return 0'. The intended
> change of this commit also makes sense to me.
> 
> This refactor is already present in v6.9 so I don't think the commit
> will have any effect besides fixing the isochronous bug which it is
> meant to fix.
> 
> But it is not present in v6.6 and v6.1, so they break/crash/hang/etc.
> Symptoms may vary, but I believe the root cause is the same because the
> code is visibly wrong.
> 
> 
> I would like to use this opportunity to point out that the xhci driver
> is currenty undergoing (much needed IMO) cleanups and refactors and
> this is not the first time when a naive, verbatim backport is attempted
> of a patch which works fine on upstream, but causes problems on earlier
> kernels. These things need special scrutiny, beyond just "CC:stable".

For tracking I guess this should go as well to the regressions list?

#regzbot introduced: 948554f1bb16e15b90006c109c3a558c66d4c4ac
#regzbot title: freezes on plugging USB connector due to 948554f1bb16 ("usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB")
#regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=219039

Thorsten I hope I got the most bits correctly, how would one inform
regzbot about the regresssion for 6.1.98 and 6.6.39 but not happening
in the upper versions?

Regards,
Salvatore

