Return-Path: <stable+bounces-254597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPbnCsL9FmoJ0QcAu9opvQ
	(envelope-from <stable+bounces-254597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:20:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE365E5C77
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53132305A249
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54C32C302;
	Wed, 27 May 2026 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHczuV2j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAE31F9AC
	for <stable@vger.kernel.org>; Wed, 27 May 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891225; cv=none; b=pS1rcxJnnuH9+TM4yYkLgB32OYevJgK7sGio6uX+t4qZZXesVhcU7uh1aOXgF/4bZ5RUbKjc/EvewmhR/JCoejb/GZINCO0CTcvECw/CEL4FYUNLqW6jgb5fC03l07FJn7ocy9KBoX+zrI89NwV5Pl6N5vArJJ8AT+37pkHT5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891225; c=relaxed/simple;
	bh=sWweHHUUo7udvvA/+md6SXyLsOiMVqfLbTA7oLbC5uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=nqFJ9B/D2ZV2ccShIG4FJmgpsWsGjElsXlOeaowbSzpEVg+p3GTGGAeDs/A9BQDg20a1T0aJFmhPuUcYjqolKPw8raDGfIyqM9nE2fKZfwA/vpYFd9X6kiU2pS7ol+NILNQNKC5/M3GW0vpP798+vV1s3YIMhEjeKkt/4CyADnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHczuV2j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba928852a5so82250105ad.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779891223; x=1780496023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fXQaASvIzd3Xl5ViHRaAzTexLFKYxxm1JbU0Z645Tk=;
        b=OHczuV2jN81Uhy5AfjJxIns00GiTc9nVSUDwjJk55GjkCtmlswxyt5Rbd6bqzcjmJG
         mbhPFYe/VrMD+JfJXWEujmDlxoyRfeJVHQm5xuL2zNgyEzHfgL5E7BqoKOy7VDZ5ikaJ
         HUb1obnVAzHsA+/5z2iAXyDQxbleoLk4jzSUlxWcrgps20j3K03gq1Wo2DZ1VUe22Ldg
         L3lJiiMk/yQ25m1/Og26WHH04bJEA6ZvK7+8zH8ANZmvTHos/76YlaBaXRzrYImvQ0Gh
         DFmtk3du8LQW+0OJSpIjeBW7Y5BV7NXmxhI94PvhEziiVBa0bZefWzK23ZFANkVNF/8J
         9IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779891223; x=1780496023;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fXQaASvIzd3Xl5ViHRaAzTexLFKYxxm1JbU0Z645Tk=;
        b=NJbYyNY1iczau880+b9dDm8PGQQCvPTq333wOCzuESmAn45EWqVixv92upquVOgvlb
         kyl2Ddm6au+Hmf6KPoYdSWuTaiU3iTXRk5wyxY8tIKMCgi6bprjcOOdj9hW0Zcw4Wyj7
         glocwIpFRDCjzSWQ6PkaggLFhz4/XdWFTr5ObGUuXnX7Y1mXLKTc5VUH5nE8z2dmYByZ
         to6wvXtlS4x3N5o1Vmxx8rDZ1NDezxxeO4wUDZ09enpuUtfwyrajsS/Nqv745FkWEmz7
         TdvMPQkuiFwkZJuDhTqwaUjyun2D7F5z0iUgUCqDH1g+N7m8+p7ADLnl0qhRfrGKAzhx
         Q36g==
X-Forwarded-Encrypted: i=1; AFNElJ9oFruR+AWcNbDW/r4uyghy7vXcEgIn6uOC7JigeK0uFxuzuBmLEee00YJJV/B0Yp9+NmX1Sgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgk9LzQ68he8bDC9P8b9CqTkKMFNKBwfzf/WRQK8Oxt8G8atS4
	3L1vy5bt1sZQdMjtvhjgHI1IDUAuSOMFUUfSrPBM5074Nmyp8Af/3kd8
X-Gm-Gg: Acq92OEHMce2VnVZJrkW9dXC8HGGUgXuSZcjSebGsVWOuNELbdlmgs8nZPE8hf1K37B
	taCh9qxPl9qjOQtwpPo6aFxDsdRLmUA+OJqYTZCC/FTmR4BSolXTTufM0VrihA5WKKXUcYpNn/5
	kPc/chmPQYU1qxZrfjHZ3Cv5Os42rRjAm68NCgDxp9ly0R2UbNr0ceOsEfx6zFS2hGqI7LsvDtv
	kicgMVC5MGTSFQa0pBYoEp9iL0avFw4H6oHWL7bERm0qtWxUiym5bgu21EP2pgn0klNyXF/+f4x
	lVk0F5NFsLUqPt1sdwiGnZYWuYjKITFBc9zTlBS+i1lStdltJslOKwxcPrEuFgXY4mOHZ7VnJUb
	WANY/TXD2FyUM+RB1dYkLu96YqJxz6sFIEglZgLNlI5+jC1gcKMEV5q7/Z+70RkNG15G9UrO5GC
	pNjpRCd23ORxLf8xmZ0/WBlLUd5k5e/BbQyKkWU43toWA/zgE=
X-Received: by 2002:a17:903:198c:b0:2bd:2de3:519a with SMTP id d9443c01a7336-2beb06ea5e1mr257189885ad.7.1779891222695;
        Wed, 27 May 2026 07:13:42 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c31a3sm155458115ad.55.2026.05.27.07.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:13:42 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] zram: fix use-after-free in zram_bvec_write_partial()
Date: Wed, 27 May 2026 22:13:36 +0800
Message-Id: <ahb8ELI3FxoMalaX@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260527072414.GA17856@lst.de>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com> <20260527-zram-v2-1-2fb84b054b5c@gmail.com> <20260527072414.GA17856@lst.de>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Christoph Hellwig <hch@lst.de>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254597-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Queue-Id: BDE365E5C77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 09:24:14AM +0200, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 12:49:24PM +0800, Cunlong Li wrote:
> > zram_read_page() picks the sync or async backing device read path
> > based on whether the parent bio is NULL.  zram_bvec_write_partial()
> > passes its parent bio down, so for ZRAM_WB slots the read is
> > dispatched asynchronously and zram_read_page() returns 0 while the
> > bio is still in flight.  The caller then runs memcpy_from_bvec(),
> > zram_write_page() and __free_page() on the buffer, leaving the
> > async read to write into a freed page.
> > 
> > zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
> > ("zram: fix synchronous reads") for the same reason; the
> > write_partial counterpart was missed.
> > 
> > Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
> 
> That's just the last patch touching the line.  This bio chaining goes
> further back.  AFAICS all the way to introducing backing device support
> in: 8e654f8fbff5 ("zram: read page from backing device")

You're right, thanks for catching this -- will fix in v3 with:

Fixes: 8e654f8fbff5 ("zram: read page from backing device")

> 
> The patch itself looks good, though:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

