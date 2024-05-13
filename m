Return-Path: <stable+bounces-43740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106C8C4813
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 22:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696AD28407B
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575E7D40D;
	Mon, 13 May 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jhrRcfP0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44E7489
	for <stable@vger.kernel.org>; Mon, 13 May 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631216; cv=none; b=J9s82GUR8DHtQe4AB4+BZDcUiW4dXfZsDY0HDl4dLbmft08kXI+pP/D0yKDLbezPQE5bQ2sDmzu7uOQ3W2B71lyHN/aQ2EHwWnUzrO+oUH5wZEpFjDjBXV9s71+L6w2ejaw6LebTqCtLM6D4fbji4qMqXwccaUHBQREmxZ6o7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631216; c=relaxed/simple;
	bh=FXyVJ3kK/TZTaEzbmp0zXNN+UqrbsvSaIXlChe9rz/I=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=cAGuRGwLTy/PCEyJTrPD7pGhkLGexzN7hvI9azhGaqGyDspO+FYVLJ1M8HuI+/74DmIhld9nz+YfXjdZLrcMm8LeZq4oXKSS6LIWlIQowxuqmQ3J76neuzSE/MCbSAa4/HwfNkXsWUISL2WJ+uevsT3UTQtXCqN5wobTUj2Z5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jhrRcfP0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	In-Reply-To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FXyVJ3kK/TZTaEzbmp0zXNN+UqrbsvSaIXlChe9rz/I=; b=jhrRcfP0R5yrQxuCUuFgf30J/S
	GTT3xnGWkY8lf2yUd9fj8W9gWz4kcr13RQYSMX/DielgiITnAWaogbjSNlDV/+KrqgOWP4tlXXik/
	p05g/VdQNGBHgqhbZSN59ysQOwSpO35BEfFgvKmy7kWtiFk0sNoW9xhwzb3eQULD9WRgsZIZhQtdw
	YpO7wG+ODq7YTTph+ImV5/u2frrzb7KFdbaGR4X/wF0RoFfamjqePKzzqlxroQ+64lpvFq5Atxm4o
	1FFXrDTC7zuoHpB/Bhg9ZXbPaF0e61bpvBuvrJvSbDSWVwhYghb91lzu9dUwIaKSZ7PIBpkCOjEJX
	dxm8apZw==;
Received: from [179.232.147.2] (helo=[192.168.0.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1s6c38-007gLR-G4; Mon, 13 May 2024 22:13:30 +0200
Message-ID: <508f4b62-61bb-53a2-69c6-cefe351cfd90@igalia.com>
Date: Mon, 13 May 2024 17:13:28 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
In-Reply-To: <165451751147179@kroah.com>
To: stable@vger.kernel.org
Cc: gpiccoli@igalia.com
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: FAILED: patch "[PATCH] ext4: fix bug_on in __es_tree_search"
 failed to apply to 5.4-stable tree
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, this message is just for achieving purposes.

I've just resubmitted this fix for 5.4.y, as a working backport [0].
Cheers,


Guilherme


[0]
https://lore.kernel.org/stable/fc7a7af9-b8b9-5fa5-288d-f04d1d7a6437@igalia.com/

