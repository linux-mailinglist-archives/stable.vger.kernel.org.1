Return-Path: <stable+bounces-152743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3459ADBDC9
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 01:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1D73AA7B1
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 23:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647B1917FB;
	Mon, 16 Jun 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cI3WvnD2"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EE40856
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117326; cv=none; b=Ohd3SkdJamGu5RUYcN56vAcl6M/DTNAUW8WYPhSOLmQqJfbYiq319CSFnas6/KoALIYGequGJy+zMIZvA0c+LudJ6GTYMqiq6hCebAq5lONnESfpf5TTctTu0ok9GZep1fpnQDceZDiVnU4JZFOwuvJrZIbgJ+SJruBOk26qfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117326; c=relaxed/simple;
	bh=istM0kKvlXmYmlTbvkRJS6c16iTbWRxBy2cOa4FYu3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppO/SR9KLG3QG45+ak72rGjgoowkjzzCmHgZ3VH5UYMGOlIYRE6qsYxSO2iayqezeugtOMrhvjUygIaaTJ5D1pA863Dc4WqpF/V+zMM4SKI6rSJh//D8VvnsK8rC2jInx4GKA0t19/aX0VCnRQ6D3A8nyQRGCqstfvVrQeEd6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cI3WvnD2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cYPali9Z06YXin6FSjGP5LRy/avPvcnSOeBxc3Dr9cc=; b=cI3WvnD2svtpE2syHl/YGJisfh
	Evo4gLYURrZjrIumweAJZh4DKexjKYxC9Ojv0IyGURXhIp/FiXN+WJDoAXkWuNiC2aIsXk6jWm1SR
	Q/E2zBIg9u7GQHd8iGT+J4qFHOCdCyueHEqNVzT/VRFveqXPWOEG7FrH8iAfmP/Fx5F32nubMEIJq
	Y9N/hYqHFg8wNXvOYTJA/EKvzywOWwx/Qwf9TQuFCzxwL5vZ9u2fXCB4ySpzik3//82/ye8uQoDvz
	DpKvnIVvWclc8/6z0JOGnhIuWvkQjRIlf0qmtdy2IbTmckKxKLKXqelA6K4VCSWcao6xggJWUdnE5
	xM8Uq4ag==;
Received: from [189.7.87.79] (helo=[192.168.0.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uRJSS-004Kz1-Q9; Tue, 17 Jun 2025 01:41:45 +0200
Message-ID: <7f2eac8e-f4c5-497d-b9d4-b9f12a1cf7a7@igalia.com>
Date: Mon, 16 Jun 2025 20:41:38 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/etnaviv: Protect the scheduler's pending list with
 its lock
To: Lucas Stach <l.stach@pengutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <cgmeiner@igalia.com>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 kernel-dev@igalia.com, stable@vger.kernel.org
References: <20250602132240.93314-1-mcanal@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250602132240.93314-1-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/06/25 10:22, Maíra Canal wrote:
> Commit 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is still
> active") ensured that active jobs are returned to the pending list when
> extending the timeout. However, it didn't use the pending list's lock to
> manipulate the list, which causes a race condition as the scheduler's
> workqueues are running.
> 
> Hold the lock while manipulating the scheduler's pending list to prevent
> a race.
> 
> Cc: stable@vger.kernel.org
> Fixes: 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is still active")
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---

The patch was applied to misc/kernel.git (drm-misc-fixes) with Philipp's
suggestions.

Thanks for the review!

Best Regards,
- Maíra

>   


