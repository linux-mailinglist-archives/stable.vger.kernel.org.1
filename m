Return-Path: <stable+bounces-251954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDf5Alr9DWoo5QUAu9opvQ
	(envelope-from <stable+bounces-251954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA4596449
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3FA9353329C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C5233933;
	Wed, 20 May 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezG3XlIv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4C3D5647
	for <stable@vger.kernel.org>; Wed, 20 May 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299363; cv=none; b=CFOUmM7Owj3+FVRPievKvpshoKKIgN2+EbCHjcabJWsYUP5Zl9iNjORhH7QFcuX/F6bAQ1WMleeguSV8ugG7hCCGyuoYVLc+wuv6aBYc5pd8QRN4yBpWCqLYWt3hSNP2UPH73oKVrlL8IbETIPR9Y4UpxfmQg7fnqL5N99jcGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299363; c=relaxed/simple;
	bh=DpvmlzvY6/2l4J6yYlA8b6johltNQYMgxfF9s7rxyCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrcxjq95/Yxs4kKhSDfAw1CpjUF8eLcqeKCijLE3hYO7ATWH1GJRRIlFHHCdupAot+SXBlLxcKXb1ICKKGotyBnwRAb3vCXX48IebqmiXY4o9xOG7LA59H0WWcR6SVOMi90IkvY6OKp7TqGBrxdA2ayx0xvvNc7N8AjtaFfibyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezG3XlIv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so35417805ad.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779299362; x=1779904162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUocfPeZqMUh8C1wxj8BZw9l2bs4+997e5jXLGYDljU=;
        b=ezG3XlIvKFXoX4Yf7fK4iMq3HTfvjozVxcVy5JvCpCwnHGa7e7VUYaHqWc8CsjWS46
         7fgORnxKZYPIH4fBRfxTF0gmBxkICJebwFiACRzoUo0YPYeMmfr4tf+2qfuWGt1wY5X8
         nFLBAWr/8A3dOvhGmAcgs6Qs7oC3JyU/0QCKCt0nJW/mdLYByU6zdQkFd4uG0lkv6e0Y
         3C9vtsrz8gqCvOmTYOWo6Ulu7lJiXp6KvHQyA0HHR85+SxWE/JhSj5MPpQrN7nJErY1f
         a5TiBfbmeiY4kK2S7mfTc2eNXdNwjYiapa5Ow8aK1DqnwRCgvxbNUKU3gRGscndZd4Lj
         Xf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299362; x=1779904162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sUocfPeZqMUh8C1wxj8BZw9l2bs4+997e5jXLGYDljU=;
        b=M9xAWWdAlUq512b5qbSluTKQOUSqbBLKZ+qWjJTGLAwKVFE+/N8ZmiuslByjAp15Lu
         LiraMZiIF/HRoRL5AjoRFiaUXN6l5V+7vRm0hSmfqcMAweWcKuKp6xEg0aFGVBRZmPzx
         nQAUm/hx535R73r2hfh1h6KwbqmpdJMY233Xyupyhrxd/8vI9dSDoEKm7qpcRFIgRK3u
         a3Fn/J5Lodsk6nR9wbHrvrPaH2hw1k7efZBGe4b3iXa3/O2Ktcrt9j6AV/1NZHdvVj/W
         1HRi3AKJxnBnhBBm7Cv7gf2n09DvG0qi65oNhiXWvYv+nQxSfn0JGiMmC56i/SlwF3pT
         UwTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8g4eOvC2FnYv58DEXctm3dw5RjOj2XJwgSlpKjLg7VVHp8tZFSwac4Rqoes91I/heh7zGnntw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxruplGI4g6ebgqkm2Xsn1FdN6ACWtuJhWfcJOaaY9r8I+1/FdN
	UtCgOXemIIBx5kRpcV0sgWgZalDaJ702hSKyvoo1sb9flc7UBZSr3Liu
X-Gm-Gg: Acq92OGgumfopISZUVIYgPnUk1o7f26ViHJrORVp6lUt0f373XfduZ0hkmbP5puB0Lb
	55XQ7TjBOdwTqZBOBebyoazHTBB/ilemd1yU+2NYdAwPgpbQWpbrc6BDdGL2rh3CGtCqTPIoAwe
	R5PxExL/vCE/lFTcG4SDpRZcn/ryR9SDQxxDDuyUCbqG9s6nJbT4L5eouGkZm9V5/Uc6OLhITgM
	NTJwAb4Z5GFMM5SmNcDYKUA/p+n6ds6rFoHdkS/Cw6ch444vqeSRJX6t+fcM/ZH6ZfatIEmmQHT
	sN8qJoGYLA54fUim4LQKFSD1iTYSwpQ7G1l/4FNWGhK1o0xhQ75WsyTpRctUaDcM420Inc4OqNo
	EDgm0VNjPQWeZ82Oz8pgiHlC6efX6cgD5nxLYZu9A9xRnTUPLY8VAokJspobIln0OA+4IQRC47i
	9slO4gpCX6wV6/QI84qhIqRglqAUPtCHhp5jTg
X-Received: by 2002:a17:903:1ae7:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2bd7e9e5458mr256888955ad.39.1779299361763;
        Wed, 20 May 2026 10:49:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d235e04sm233974235ad.80.2026.05.20.10.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:49:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 May 2026 10:49:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/adm1266) serialize firmware_revision
 debugfs read with pmbus_lock
Message-ID: <22158259-31fd-4f0c-906e-46d93ad44f9a@roeck-us.net>
References: <20260520-adm1266-fwrev-fix-v1-1-8a78c94a53ef@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-adm1266-fwrev-fix-v1-1-8a78c94a53ef@nexthop.ai>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251954-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nexthop.ai:email]
X-Rspamd-Queue-Id: 35BA4596449
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 10:38:28AM -0700, Abdurrahman Hussain wrote:
> adm1266_firmware_revision_read() backs the firmware_revision debugfs
> entry and issues an i2c_smbus_read_block_data(client,
> ADM1266_IC_DEVICE_REV, buf) without taking pmbus_lock.  pmbus_core
> holds pmbus_lock around its own multi-transaction sequences
> (notably the "set PAGE, then read paged register" pattern used by
> hwmon attributes), so an unlocked debugfs reader can land between
> a PAGE write and the subsequent paged read in another thread.
> IC_DEVICE_REV itself is not paged, so it cannot corrupt PAGE in
> flight, but the same defensive serialisation applied to the other
> adm1266 direct-device accessors applies here: any direct device
> access from outside pmbus_core should be ordered with respect to
> pmbus_core's own.
> 
> Take pmbus_lock at the top of adm1266_firmware_revision_read()
> via the scope-based guard(), matching the pattern just applied to
> adm1266_state_read() and the GPIO/NVMEM accessors.
> 
> Fixes: 7c99762af5c1 ("hwmon: (pmbus/adm1266) add firmware_revision debugfs entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> Assisted-by: Claude-Code:claude-opus-4-7
> ---
> The previous "GPIO, NVMEM, and debugfs accessor fixes" series [1]
> locked all the adm1266 direct-device accessors except this one,
> which slipped through because firmware_revision was already in
> hwmon-next when the fixes were written.  Same defensive-locking
> reason as adm1266_state_read() got there; same Fixes: shape
> (stable backport candidate against the original firmware_revision
> patch).

I completely forgot about this one. Thanks for remembering.
I squashed this patch into the firmware_revision patch.

Thanks!

Guenter

