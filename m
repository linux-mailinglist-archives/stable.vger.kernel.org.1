Return-Path: <stable+bounces-20103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EDE853A36
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 19:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965FC1C20FBD
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3610A1A;
	Tue, 13 Feb 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7xRgkGp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622C10A22
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850055; cv=none; b=crpjZIhlU6/PZ2wSTZGRlPfQ1MsMhj1E0p7x/yu5soHzO08afCr5qJoG7kYecXy6Y7Tge5QsRPFJOeaAk1P/CiIRtviGAs/gAvwlS/HyoxJGb8h+kQMCoc/KWj8j5HK2WdFMEpKYjMhFMTRPFzi7jDaPxXHfM2XnK0QAgIRStps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850055; c=relaxed/simple;
	bh=C2M9ewzmBBAwLW37reArtWIysIiranwPC/tKhbBZn/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy+jk+OvEjbPaVieWiFfI5mUX1ezmQgvp1C68N1oM3FWURea/9jDMbTmxcvgCN3oso/SWHy2+zL99j2p9olJMaefeo2pKnh8d3+ZeZVQEStCDtmCSWhde1DirKKOOY0cCf3fa4O/ZC114wg/VEpcPxlDPcy1cbuXuTglbNs9cIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7xRgkGp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51197ca63f5so1549394e87.1
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707850052; x=1708454852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqGRxMNg6YqNolmEH8Z1CBl/hkUAAWON8BZtDgDHhVI=;
        b=S7xRgkGpVrrGJts3WzV0+gdvaMgmM0A5Jf1lWHtxgzeNDcgkci3FONkdh4Bids6PPA
         PrZi+E/H2YliQeTssWOE/IVv6OnGmRsVPJH0bBLKHVXI9mr3h06BcaFjDM4A3tC+VCyL
         se16GkiEmVsKlOAlKGyrYmuwEY7Zxs0t/PAJ+SO07sLkY9edEtPfmBI1eTNEbPMDHFGs
         zDewgTN4aVauLZh/oRNuE/LBn4a38SSCTIPYrnGJm2nDO8DPscKS5Yr4jyqqZPmf+rOC
         eSPwO7vthfZU5E73iacHEoyaOBQVDVqbRcxyRPR/v1CyfQ5EdtZ66deizRS+D/Bv54Q8
         wSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850052; x=1708454852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqGRxMNg6YqNolmEH8Z1CBl/hkUAAWON8BZtDgDHhVI=;
        b=mYNaCgeYTzUXsWM5wOd4YD7jOuGdwO7SPaZA8vDzmymA9aEGtGHYZpu9Qjxy27BVHT
         mH2AdUVNqUHQZHOhqZGP0dRFN5gcVdcVAqS5KffFTzc2EC5M9gYQ/7vuRFT0HNfrxmu1
         +db70cNV3wFQOU/gVCIiv7RL7gsYECdVqCtoJFZ32nmECFNNaZOr0Vg8V4gw/f3QhGbY
         1WY0gzjSzCVuPBY8cCHH4ewPbYlk1BZpSvfLhPWO2j84haKKbg+1JmmMsDD5N2JtSn7w
         4S/Jhce0jso4nKk3ORwiyFf0MmQqlfFQklrf0rK6EgIVf6qi3F74+icPEntWSNIzpkg+
         c69g==
X-Gm-Message-State: AOJu0YzsNyjeQ3VXyNqiwvG456lDoCjgbNot7sHVCvJbP4NJ+6n6n8kM
	27Z6UlCu3hcT8NTcRzi+sC9mRg44RQhU9XxsyzuvZjh9Rvc8zseS9Gcmz4dytug=
X-Google-Smtp-Source: AGHT+IHrkxoyUQ91Fnm+yXUC2n+RHvl3TubDysJtvp7WFp9zQyKuZLUieqUgSux9eqSeNoQJnn9ieQ==
X-Received: by 2002:a19:6451:0:b0:511:31b4:ac16 with SMTP id b17-20020a196451000000b0051131b4ac16mr268419lfj.47.1707850051859;
        Tue, 13 Feb 2024 10:47:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSF13gpNMdWWpkl8UigK3luvug0RdomM9JnCvQ0YJOu6CieO5u1V+l4zBe4Qo9PAe24wkIGxieJp4hQmC1bNm53dsxyH13RnXcRHSB5ryNiFQBGxbcUUDmF4e9XNs/HD7axnHciPU=
Received: from foxbook (bfh204.neoplus.adsl.tpnet.pl. [83.28.45.204])
        by smtp.gmail.com with ESMTPSA id q17-20020a056402249100b0056163b46393sm3860108eda.64.2024.02.13.10.47.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Feb 2024 10:47:31 -0800 (PST)
Date: Tue, 13 Feb 2024 19:47:26 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman
 <mathias.nyman@linux.intel.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 6.1 53/64] xhci: process isoc TD properly when there was
 a transaction error mid TD.
Message-ID: <20240213194726.7262e240@foxbook>
In-Reply-To: <20240213171846.401480216@linuxfoundation.org>
References: <20240213171844.702064831@linuxfoundation.org>
	<20240213171846.401480216@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 6.1-stable review patch.  If anyone has any objections, please let me
> know.

I'm afraid this patch needs a little backporting for 6.1.x and earlier,
because it frees entries in the transfer ring and this seems to involve
updating a free space counter (num_trbs_free) on those kernel versions.

There may be other incompatibilities, particularly in earlier versions,
I'm not clamining that this is a complete review.


Related patch "handle isoc Babble and Buffer Overrun events properly"
depends on this one and needs to wait until issues are resolved.


This is the problematic part which calls xhci_td_cleanup() and bypasses
finish_td() where the counting is normally done:
> +				if (ep_seg) {
> +					/* give back previous TD, start handling new */
> +					xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
> +					ep_ring->dequeue = td->last_trb;
> +					ep_ring->deq_seg = td->last_trb_seg;
> +					inc_deq(xhci, ep_ring);
> +					xhci_td_cleanup(xhci, td, ep_ring, td->status);
> +					td = td_next;
>  				}

