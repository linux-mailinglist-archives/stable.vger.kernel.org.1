Return-Path: <stable+bounces-227898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLIdMiHswGmROgQAu9opvQ
	(envelope-from <stable+bounces-227898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:30:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD32EDA06
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B31C3007E0E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25135F17D;
	Mon, 23 Mar 2026 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RewE6ygh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F835E92D
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250941; cv=pass; b=WXT595UnDJbKmV3+7lUDuF/B+qdiDkA67M2g0CreBi96c4yYGGZLLnOSBJjogSnSx4tcilxnMSnw/dutwkKcuRIdqLwxhunlK4+9OMERe1W/RpijEkUrgK0v+iEHHGxVA5LQkDZTRHe04q2RgwnVpBGAPgLpAKvtwq8RII+aWKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250941; c=relaxed/simple;
	bh=wvHVZAd+Fi3HPZRrGjELFIAC/7TxYJUw5Ev2XiIBQmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1k/S9TDvBJ9ft/NpO2nJyrXxe6furukdICCHfym22EgQbID2C+fJjGa/Ab70WmHEeSrV7Vn8HEaO0+RkFZGSwIGmO0BjwgYZKN0NFgug5s3UUGwCzL2HfDLkcW8pCKP37GAE0R8D3pxv3rqyvonm+zNs9yF8Z/wxw/CXsblU58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RewE6ygh; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a3ba1653fso25747507b3.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 00:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774250939; cv=none;
        d=google.com; s=arc-20240605;
        b=b5l/kZsqGq/gMhEpfGADnlh9+uYf4SxrE6JkMPKVkkW2oEFxtjKM5r+OD84CFblJ8x
         9CQjNzMXedemOBrDme/A8Ne0x+fEmXdP+ie727ympszr6hRbbqIZenN3JCjuMOMRSNIe
         /ocwW8THHtouu1h08Xbd1RuBYJLheQgkgpMN+pXyvoal0uYoxakaM6ENdNwkujdBddrl
         SiG78MmPJWXcn3s8Dk9iRz24/QpgQgew6F331Y+CpvBRDYunvvg4KIUMGMdFP8VJEhk3
         CLTn82nGygCi/yutubbB9J1A288tUKn5ok1yqIW5eJGxBsNK0nkzHv0XsufN+d0Q8Jaq
         Lz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EvWPIFy7Sr+a63qZxUwJP9iWaDI1gTywKMYkqyTwgs8=;
        fh=Puwz35e6WDSaFqlq/WnVBO+jF4CZt4fq+guh8GB3hQc=;
        b=Smx/k6J6MO4mW+2IbPn/JuiurGQAjXwZhkG+lrpwfWuG2TtffjTapYOWve3Rwjw0fy
         FKnFRNLeD78/FLZC6zyn6drBouPQNFN96z0ickDYRVRint7Wbt2c2JBU2zzbkjBModS4
         sDufBRT8AWk6MUSXAtTrmAl5xNPZM37AnkQT8ZpAPHurz3LlktuYhX+K8noNDH/0EPiD
         M5ooDbqS/WtxZWb14NC7qg/VcBLwmddwfHvOff72MTO4GjRTd6KC0LKRX2Yac0VBmAVO
         d12oR2Pw8xWK3D6W63NjRGVOfudbgcQYPG2dq0+74ZHLsOWJsLp/9IWPbCL+FZmadvX9
         bDgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774250939; x=1774855739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvWPIFy7Sr+a63qZxUwJP9iWaDI1gTywKMYkqyTwgs8=;
        b=RewE6yghKYz5X30hMNXNPOqyHsywiCVGM82Y4+rXNVIYEEbfpKwQcK96II6QhdR3Qo
         JhclLchGVH5qUxr4gE8BGz81D5Cosh0mFhdGdxX0ejKCCZ0QFiF7O7H/yI3EpZ3UD2dN
         ernwEMjhV5j8RKGWuVI4YwngjhO8OVXLBzzKbNfrZBd9oSM0MZIOLotN1O0fEn1rahJh
         vlZQzsoE/EJ4ERcQEhOfJ4YP5emyIySLqLx4PvYVPssqJeKLhDo9moJkHgU8Wp4V4yD+
         Jdc2w0N68j8LB2ePvUmTRAjbRO8fW2w+fcUZ5PGqxNHNiSxRmKPhpBGoTjg2b8mfvvl+
         Q93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774250939; x=1774855739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvWPIFy7Sr+a63qZxUwJP9iWaDI1gTywKMYkqyTwgs8=;
        b=MFF5DffIMz8/d7DLWXE1vj5mKa38q1jVqgJKUd4JYxi/OR7+fOxf+gpa9vU32Bxvv8
         M+2IPsDz+FTVcIMkV0bBMJgo/7OYvy37UteEiFkqdiHNJADymryJc5tRCucvKEQ/wRw1
         LVl2tl7GGk/vkxnjV+aKp7RwWYQuMVW+XpWtUQeeNXgFDje2H59PA9tnbbsdrH5euekJ
         WYz4BpuGly4XLA5udFnwbXtut0DSVeK2AlisHXi015pk6lrsosC6kWwLJW4gb0f2hwZr
         AWE+Ny0L6q8bvVxY2mJToL8OfNZ8WOuksFgERnyts+kEZPmX3prDGzWV8yIvOncmq4m2
         zYpw==
X-Forwarded-Encrypted: i=1; AJvYcCWVyNVFzy2MUiv/9BJn9TV+mX9idM90vXBIsp03LyxtOYwRzvXWzXlwk1MlaSd1dEKgIT3AKDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCjOcj9N5ViElrlLheABQu82NhANmDN8nQ02CastW0HmGGmR2Z
	1LieY+hIu3GBD9s8pjdZUAx1m/jr72uXzs6SRgHQK//2XNXwnQ6iIqtXaRTiOXC6uqD40gbz+SX
	43MNU6KsOZIO0WcjaD6FhmhfWPhchGUU=
X-Gm-Gg: ATEYQzxZ/iwkotnidESrLygShcJhVBKDW/CPHSax2AoCvmnqptJvI6k/MpbiARrZMxM
	1n5+mvWiT9k6zXVV9BzriM2yunvQzfgoNaDRAhIUGizcWb+s5NrcTkIturzIhKw/KgHi3+YjqYf
	E1qoL3QDUPmMMqbWSEK+4sngbd/W1HHCTCfji65tI5PTEeXj6oUkg0eauBPPhotfyP+/9wslaoT
	+ROiAhZFgQAXAJyYkvDzFeGguJVmhwnk1//g15X9ZNcpyifCwNHRmMCmYDpiqBhQNn7BebhpyG6
	7o3H9lnj
X-Received: by 2002:a05:690c:1d:b0:79a:b245:f8c4 with SMTP id
 00721157ae682-79ab2460c5dmr33281607b3.54.1774250939273; Mon, 23 Mar 2026
 00:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320025507.3331221-1-zzzccc427@gmail.com> <acDaQ6DQ7ehMji4r@infradead.org>
In-Reply-To: <acDaQ6DQ7ehMji4r@infradead.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 23 Mar 2026 15:28:47 +0800
X-Gm-Features: AQROBzA4Vz5OqSije-jDYcg7Q9h2EUb79CdWV3qLpnnFumua7OffByRbOEQbquk
Message-ID: <CAFRLqsUdn4AMsvnVopHuK3zX81FRFQj+GGdCGO9KgyBxckhWOQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: annotate data race on li_lsn in CIL formatting vs
 AIL insertion
To: Christoph Hellwig <hch@infradead.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227898-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 2DBD32EDA06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christoph,

> Well, xfs_trans_ail_copy_lsn pretty clearly documents that we actually
> need a locak for the 32-bit case.  Assuming we don't have lock ordering
> issues, using xfs_trans_ail_copy_lsn would be the right thing here.

Thanks for the clarification.

> .. and either way please avoid the overly long lines.

I'll update the patch accordingly and also fix the long line in v2.

Best regards,
Cen Zhang

