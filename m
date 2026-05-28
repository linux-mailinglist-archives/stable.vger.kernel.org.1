Return-Path: <stable+bounces-255049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJAXNq9kGGpEjggAu9opvQ
	(envelope-from <stable+bounces-255049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:52:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D99DF5F4A5B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 119A53021397
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C93EF66B;
	Thu, 28 May 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="pDIXDRyW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B42765D7
	for <stable@vger.kernel.org>; Thu, 28 May 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982558; cv=none; b=t8ZnX5/YP3zJGh0BJf2dDbDBFrKyqbpBM9wDqrTyUmsJupDCbQDrydrTBkRYHNsxJG5Er17ISxxXN4boUw5RnpGyvLD9kNWIexd1hFh9NuFYozswvj7N5ay77nIj4XwyPk4dNqlPqg1VvsuCo9vXZWn0vZCOFRTxDTn98FJgaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982558; c=relaxed/simple;
	bh=0+L11fk9Izyta9S7kJVLDSR1ngYMv8hAklu4/THTGcs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rYvUU9++bPrctjVtm81FptzyPBk91wxg2eohNStXPU8cXJpfhH0tkct6NdFln2QXxRtalz2slCRNDkjFjL0RCPRvzDpKDV+NaYMLrH+77jQXCii9SDSxS8DwKk6INy9NW5bOo9HeAXnsomRRjX36SzLq41ks1mNFDiZYCeNHqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=pDIXDRyW; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43b53f048beso5415952fac.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779982556; x=1780587356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz1kiqoLVJ6hRG23SPw7NRuc6dgMEOLrO9vqYLBNo6w=;
        b=pDIXDRyWVep7CycnpeEt42TjSyPTeN66FksEg904VXsV7RnQ+eZJJYaZV1jjt5G/P2
         FJjuFMUAXzGO+Brtd0pDH0EAS1ofsMdQpLcx8h1hi88vuOcn8oxKRU4EHfK6mLuw774z
         oTDIjAD+ao+S4cfPycSSy+hJVt/dFwyUhmn5u+m4EYHHbC8TpHYO84RlvS4reZK+ub/L
         F6/mUTaOFWzuBUL9aH5n/IeMAvJVTbU/U5joiRA8PEqHjdKqKYOwvVUE8gDeSHaqSgSm
         /tReSekZSzuh66Gz9PGQwXxK0OWQ6tpQxDh7DpvHww9eqdbUhtUKpwRE6PzEU99FMNEL
         H6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982556; x=1780587356;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dz1kiqoLVJ6hRG23SPw7NRuc6dgMEOLrO9vqYLBNo6w=;
        b=hnuFJjTZJcAdsOICNrnWuo+tj85tRbOrOwB1BG4gmdggs2AUzp8QwRObvHsSknl48w
         wVGrwnCTapzVdfBkIaFOHh3mDZNNYVdzLSsqkYmRJiMuGPiMgXObaycdCC8E7ybgwnC/
         +L9ZNqpQ6TImGFeKr9kgvOWpDQSZYxrGA2s38g9P8KrAAPkXvLGQAOrA/qmu9ib9AbEy
         PgYn6lhdXCYWR2ykb4oc6Nj1lA4oRatppj+yME5emjbNupoVwUmLkMX19dJtgVEHHp0i
         iSstSYDKOD0SOvQBPFD8zqa6Mv6w1fa4hYO7TG+Mdt4ZUWHKzFtRMlh1uNm0hKXhGEQ3
         RWmA==
X-Forwarded-Encrypted: i=1; AFNElJ8wEp5haD6cSiQ9WpUbW09Ujl4KxrwqwcN3GRCVIMTXO17o/0KAHmvha2HN4Nhq8iwsODNG1js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtoGuKsdY/ChM195wE5LBFkGjeyxAKsbHXuXQ9GOPEW585EwL
	5vn5glhNvhthkjmt4wG8xdBVlM61nVH2gtE1W032Irtkr06te24UIBikW+z9FOcFzgQ=
X-Gm-Gg: Acq92OHMXh6AkzAhp30/B+UBQhKYYSBlHe5xJgDQVsBL9+clX+snZZ1BCRiw4Iysygi
	L0cd1Vh4HvT+SjIpOA/ACzfP4jZFBtNGa7lgCsnq76lGwFcsYbszNI5RIUAtSyUo9nEJldYnmVJ
	ZmEX7RBtxDwv+K2GTYh456Rk/MWF19fjitVEaXkIICGh3IC6iGZirXljo4Gc4p/X/0lOEMxnNWa
	3g57WJWcnIfESKTQ3Jg5U9FQjBYkOHZvlprT00iJW7G0wrkrhg6ThvcJwHK/p40FwuV1komuHAM
	TuPqxJOHn48pC8zIEDGvxiv8ccuiLt0r5FtY5iPciG7Xs0LOBJrCR11+xu92GG0mxZeL+Lffivq
	btjVOb05f8CuDJBLW68sYzkFH9UJ++E1iVUn+5dCWEW4aJh485ze1Leiynu2L+A6RgbWdyAfNEI
	lbcUbwtLBqIM+qbeYZu6FF9oidIcdRO/jrLGOXUEOchfN54/HbPtPLObibPQPFm3mwqYkZYGueH
	w6X+sFkBMD6Kw==
X-Received: by 2002:a05:6870:6f05:b0:423:9751:c1c5 with SMTP id 586e51a60fabf-43c6c98709fmr1119076fac.22.1779982556503;
        Thu, 28 May 2026 08:35:56 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63976202sm17548732fac.12.2026.05.28.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:35:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
In-Reply-To: <20260527172203.2043962-1-runyu.xiao@seu.edu.cn>
References: <20260527172203.2043962-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH v2] io_uring/io-wq: re-check IO_WQ_BIT_EXIT for each
 linked work item
Message-Id: <177998255558.134892.12462292234696248083.b4-ty@b4>
Date: Thu, 28 May 2026 09:35:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255049-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D99DF5F4A5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 28 May 2026 01:22:03 +0800, Runyu Xiao wrote:
> commit 10dc95939817 ("io_uring/io-wq: check IO_WQ_BIT_EXIT inside work
> run loop") fixed the obvious case where io_worker_handle_work() took one
> exit-bit snapshot before draining pending work, but the fix stops one
> level too early.
> 
> io_worker_handle_work() now re-checks IO_WQ_BIT_EXIT in its outer work
> run loop, yet it still snapshots that bit once before processing a
> whole dependent linked-work chain. If io_wq_exit_start() sets
> IO_WQ_BIT_EXIT after the first linked item has started, the remaining
> linked items can still reuse stale do_kill = false, skip
> IO_WQ_WORK_CANCEL, and continue running after exit has begun.
> 
> [...]

Applied, thanks!

[1/1] io_uring/io-wq: re-check IO_WQ_BIT_EXIT for each linked work item
      commit: 29bef9934b2521f787bb15dd1985d4c0d12ae02a

Best regards,
-- 
Jens Axboe




