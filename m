Return-Path: <stable+bounces-253450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOYVFjmSDmq8AAYAu9opvQ
	(envelope-from <stable+bounces-253450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:03:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B418559EEDD
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBC14305A5FB
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68644322522;
	Thu, 21 May 2026 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oWuwVmMJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B91E51E0
	for <stable@vger.kernel.org>; Thu, 21 May 2026 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339713; cv=none; b=jjhHl6Ak2wPfvkZ8i9FVy/1WAbRYRXuO/tyDVS6bu9ijiHCl8kx5zVLUCuaNl2w7KTswn895fpvFnz0TI0EBEXugIGhsGRIMRlx2ZhrpgHy5g/43a1WF17GA1FiCyuBBkIWstpRCWNnPyKhxdddNh39Lozl/KP3IoULa3bSg/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339713; c=relaxed/simple;
	bh=4AmoVcAxGgYuhcAEjmUp366n/PgeGXRmOdDpg2vN9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra6JR9+yZua/rJ8H/cbmY2GLieRszwwm0CWCFfv3yO98EWqtSreqhNxrDnvKsxhZLohGgl8zwv+bTkrDYEC15YqKcxJ0ryYwrB88ZEj7J+Z6MFcUehkLel9GP73Y7EOCdzUwn7WpHlz/qJMsJNABXJfHGp/L3Tcx/kK+VHLNU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oWuwVmMJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso4763979b3a.2
        for <stable@vger.kernel.org>; Wed, 20 May 2026 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779339711; x=1779944511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wnZVoUCCljfOdLQTbvx1Anl1wMMD9vwz2i/wxMjUBV4=;
        b=oWuwVmMJio1GN9VAacKGgKHz86P+uOkNhsSfNTDlpeS+zT5BDNJVUNCtyFuCnW0BCa
         onY0Yzr7Lx8GiUXxlW29LO0szgqqzqUVl1Ur98w8bQ8Ih4zW9fs+XlrmWvzTtWyHS6M0
         EHzayF3xrlWpIIHu5aPRHX2jRWBtQ8zMhyg7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779339711; x=1779944511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnZVoUCCljfOdLQTbvx1Anl1wMMD9vwz2i/wxMjUBV4=;
        b=O0kK8CtoUACP0h628ISuNXm0RlWMJfTEFkVlXbHFubV1k1tvm95n9eyauUf5QY6dvf
         WkJ3TAKVthEIxMA+UQfsIZFah0cPYHaL5fZTydlDiONqrHR7mv/n9XeL6V18Sfle1z2p
         MKqqVsHWd91CAqihCZGFRtAlpi0jz1QQQG+e0W9ci3LL3XZwVl7f7B5jaHEuNLqrH4PR
         taehRU9Qsxohm2A/rh3B0vFTMFBF+L+CSae4X70H1izthIV3qGazpVWA0UXhsUgWOAQ0
         S7YmNMvJmhpyoAD561j+N7oryfd+AAR1Y8rqH8jE3egl1IK/a3wTV90tQfnfgqGn+K1n
         F4KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hIOVI5vxY5E8A11TiwKkRVud8a/fgFHjx9pKbnhXRzQe3a4msCJwm0hWfzzD43PnLfmtmCbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+p8176caX5tUAJXdeTd88gKEViML8yaspwdLQzCj/1/O2t6H
	zot6pilvAe5TCjCFqauz1JpA1XrUND3PY4+DXnFMyWNwOvsw8T1U8Gs0q30Z2ORRRw==
X-Gm-Gg: Acq92OFJFIB4/HElrhb97SlN1ktPDobdjKuzJaFyqJ+xAiwURRQ+9redibrbNNGW+K+
	7FeOFqIojQ9ieHe6D9ytfLZFlsDYWgMXOxm4J3CnuSI5pu1ysLihIb+k+sdNINQmO40xgVzGRbE
	7+ArmHZhqAySlv3KBByKLcJHyJu4bj4B387RZzwbVChdFMqN/hvLOSPE7yoftQc9nalnBBqhE0L
	JHLl6HWCdKQ0/PbNtK3FKlFGNumrRvO2aQPpqGCyLJM7cKGNaj2P2YerxSrjbwYnRKD/rYB7Ccn
	wxJ23Xz6iw9piGI/mXrT2ZePBkhSEaaJQP3RA0VQxOfIknAvcMK5ZZ6Bm/QuA1KWAn632lJogep
	p+UwU/Ws+w5wKVNZCwYyvSXfpHS3Re2XkCKFEnix7+5cPlM5Z9jSdZ6mr6aYNSWXFT/VSvX67Ub
	5vJmoxJa5/vwNhmaai7fZlPhet0sopUJaPJq042811ez4zaQtDEny3YVAw79bKLZ4Os4kojO+/o
	w==
X-Received: by 2002:a05:6a00:b48f:b0:82f:623f:e5b3 with SMTP id d2e1a72fcca58-8414ae6ed5emr1322644b3a.34.1779339711331;
        Wed, 20 May 2026 22:01:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:9e89:7571:583c:e885])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm21984174b3a.57.2026.05.20.22.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:01:50 -0700 (PDT)
Date: Thu, 21 May 2026 14:01:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: ucsi: Don't update power_supply on power
 role change if not connected
Message-ID: <ag6Rqi_W63sP7gU_@google.com>
References: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
 <20260519-ucsi-fix-2-v1-2-6f1239535187@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-ucsi-fix-2-v1-2-6f1239535187@qtmlabs.xyz>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253450-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,qtmlabs.xyz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B418559EEDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On (26/05/19 18:41), Myrrh Periwinkle wrote:
> We only need to update the power_supply on power role change if the port
> is connected, because otherwise the online status should be the same for
> both cases.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
> Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>

