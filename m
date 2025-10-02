Return-Path: <stable+bounces-183109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D3BB4709
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E040719C3308
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12891241139;
	Thu,  2 Oct 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b="eFJKLyWL";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="vyU/BMal"
X-Original-To: stable@vger.kernel.org
Received: from e234-52.smtp-out.ap-northeast-1.amazonses.com (e234-52.smtp-out.ap-northeast-1.amazonses.com [23.251.234.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B65151991
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421197; cv=none; b=dES3iRZiJD+3HJY38pdYNOpP8l/Va+/qDGW8TwBU6y7XjxX5PBzMLrkARvA1VCVFGj7BeYxzp9hm4HN2g+b8OhX0zMUHUDIE+An9SeL++q2nP+PxwnJ9KrFXxxcmE9aDhwo4qNnAw8s/31tPV4Fx6Ag9X4PQVnKz2FKyIJatAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421197; c=relaxed/simple;
	bh=8gOOO9aLcgO8QiYiyH+kvBavcv2mamJigKNUyHAeKrY=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=LkSDElb5eeDaAli8i1uUvlbiXGvuWc9EVatNAQWeQ3Xv9Hnt3XRfg9FIw1rDWcAzsSObi0Ha8Q9RGspOL2VyRyU2pfAvO5iin7P8SvmMwzKst1QV8w8ybfvG2le9kFXpGD/H7QcqGT7nDLOqsxDFk/LVeTsArd7W9diTrIkXQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=eFJKLyWL; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=vyU/BMal; arc=none smtp.client-ip=23.251.234.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.mgml.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1759421194;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=8gOOO9aLcgO8QiYiyH+kvBavcv2mamJigKNUyHAeKrY=;
	b=eFJKLyWLPRJIFTVA5V6z8tZG55eZnDpA07iJNRM09wmhR57Ensd77ZbLdQ3T5QxY
	Ntn064O5DSCCqIKqm1b/h6eaYRbn4KfkM26b54bTYNQV0ahg76s7f6VMa42pbM4WSxu
	VECnVphOHdqFKWRYZeR8dzB/jRemypsNYZtGv3zE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=suwteswkahkjx5z3rgaujjw4zqymtlt2; d=amazonses.com; t=1759421194;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=8gOOO9aLcgO8QiYiyH+kvBavcv2mamJigKNUyHAeKrY=;
	b=vyU/BMalqqaHivD3bTcHBeM8hqMlumQt69eJ7RMKKpZjDHSe+vuD4tYPBIaK6GYv
	4lYFt0Qfp03gH/mOdDQIZvNQ8jEAKG2kcTW6r/3hauqUcDICovI0A70eQj0d8vTIiBp
	mvmuPfHMo6KgKfln09xc0/Gm5H1Qj971cbSzR1Fs=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <b21abadd-05ec-42d4-aefd-0493ddf54c56@kernel.org>
From: Kenta Akagi <k@mgml.me>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: patches@lists.linux.dev, martineau@kernel.org, geliang@kernel.org, 
	kuba@kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1 54/61] selftests: mptcp: connect: catch IO errors
 on listen side
Message-ID: <01060199a5acdf5f-568aa6ab-e765-4a52-9400-1c235760a3f0-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Thu, 2 Oct 2025 16:06:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: ::1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2025.10.02-23.251.234.52

Hi,

Thank you for your detailed guide. I have sent a patch.

Thanks,
Akagi

