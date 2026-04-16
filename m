Return-Path: <stable+bounces-238320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDI3KMn14GmInwAAu9opvQ
	(envelope-from <stable+bounces-238320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:44:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA440FB91
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 491873063123
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB03E121B;
	Thu, 16 Apr 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Vkz2Y8Xo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1242F39B4BC
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350656; cv=pass; b=VrUKMojrvZKh+pgVMZiFINaoAbzooJIcw+a6RrHSAjuyBT5+JisJnpB9KnX073DxqnMKn/2YH0bjaSe6nKS7TNGfDqaym5Ue9NPLbkF2NUweoYz610DTGjdAapMPMIdUAYBY6V7dtwnfYPgwXgbuGX6MuigbRPv/89JzA8+wh/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350656; c=relaxed/simple;
	bh=uY+xFfoVCtzNy2f7dBFh2baIj1I8x1776kXCRcjjm3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oW7Qm0rrBMBXSs3o36gogRQmiQrLvr1RNTR+nJdwXH+44g5YK0EVQSkQeP85wOXVTLYO1pDyXzW1orl45ip02WTXrSU+QKpFf9/rvuOZKe/xxTWBTiJbEdyOUGrSmJVgHaBgcot7aPuhtdk11RxMIi5WZD/ljSqhoEC+2n4jjMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Vkz2Y8Xo; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50da9a7928cso65949391cf.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 07:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776350651; cv=none;
        d=google.com; s=arc-20240605;
        b=MzvO9NmPjXMVjlhH/XeRXN+sDVXbDB8omhJvJR2NE5J1vtc07T3abd9bQNbqCrh1zc
         rsqFKuQGDvvEmgZDB1zuIedJBGm0Fv2wK2f1BxWxeXjfb6XcJZep1T9/njVYdmG8Pwyw
         yI6KSpI91GnqZAIpEwiyJ2Kz3glUFI06Ke05Z1H7ayHEHhaZwKHv+G+BlOb6Jgksm3OL
         27SrMlgtqRCMFdWYi8sWlsguaH7t2TV80C5/XLtdFvL7U+PiXIYOmtQXE9Ez3S1k1Ol3
         CQnEVH6kBfca7o1PRZo2isOQyCwCD5TsvuIMbtWgC4m0FanQxtJB6o3wis/sBfv8F2WH
         aomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uY+xFfoVCtzNy2f7dBFh2baIj1I8x1776kXCRcjjm3U=;
        fh=q4pN0sAsDnK2Tprodrfmumskq1j3SNYs/t4kZ+R++Xo=;
        b=MYm+e18MYjvvDAXxrJo+IMvmDx1p/aOYgzihwKNjcqMSZ33e6S2e5iBETm04fsdPlq
         h7vNAt1TaY1ETJYPl9FcLnCswYMKxKIJimGUdrI6frhNOyud9IPkS7m2T9gB6w5S6Tsz
         gM0xl8GMw/KvFRGZA8GxWUMrxYgY6H0FEm6Zxs9/GfPBJaWQepfizcvvIGJwGt+g08EH
         jIegpCUdwIXEdgTd9UEEXkPPHgAtKNDDz2kiO+iq2CWbqO9eCzE1x58+HR8HIfOAj4dY
         LtQMb2bDWKAQCbvNxkAs2r2nxZK0LiYofwey2JRVYReY/dG/apYq96rgRhCzmwxaiwVb
         qYig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776350651; x=1776955451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uY+xFfoVCtzNy2f7dBFh2baIj1I8x1776kXCRcjjm3U=;
        b=Vkz2Y8Xoeai4nTDEXzYoHRpchx5F3hj9pq+TKfqVd/COauwMzp+tiQOLJOFzAYR8P5
         OkB3diwv809cIAByqX9BnduaMgkTGjc8D4BTHSFgjWj5LnKfy0i8txFpBaokadZ84N86
         3Cs1m0pvsmywvRwuL5mZTjaqEq45nYpApVkQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350651; x=1776955451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY+xFfoVCtzNy2f7dBFh2baIj1I8x1776kXCRcjjm3U=;
        b=OAchf99fLer6yHRMvLMpjnv9dsc2cc+nBkckG1JIrL139MaE+NCxjQLaf7a6TwmR9z
         ymI66iBXmmuNZbHQvfHKkFjz/16Jfy+J65Wji/rK7Azc24BvkcowAuIxoaDm/1zNkCJc
         r6vhNsbFe8B+6CziNUamntKbifOnDiFUV6Y5aNFa1FN4zbYqeVEdTPZYwhjM3wR0CXka
         iwm6uQeRrZGU3ceVxmtaJMtzcMwSAn+Q3rLCMzxJ0DgGA5hesVddxvzPCOt95kxYB+/g
         p0/dSoLZq0+wxEIRmM+uba+aZ+ZzG/pV/Saop+0PKFjr7iTI3pL0QDkiiB+lXOb3gWWy
         d/oA==
X-Forwarded-Encrypted: i=1; AFNElJ+liBYOGZVEVODSn52VWosJIA6xq5yX983DktK+oOrPn2bL4WtD5vJG0rq2ljKNHQ1w7kfcNbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUF3Bz4ixcRqjCJVaI9KSu8Pso7CXC68A8i3kiQX7bZvcXaMDR
	0VKsTC0Onuo9M0Bci92a2EkQzBo4uIr70z9i8f7EYQLA487akri6goBQajqEKvA7+DvQWaqafPu
	J5v0SPz/r8WOESvNK0sGmqjyouiholiLglvGl8aNl5A==
X-Gm-Gg: AeBDietpd+yB//9MMdscDaFHzHLpo8hhsrbSkPC27/er1PWg2uVwd1x31XUeTtBrN+k
	/CXh1b88hQx1bxjbcP52wcNsmFr/NlUjfBlTv9GZWFdvIbAZ5jM++Z2nZgWwpkZZzzSPQsgTy7V
	qZJI3GpqUmibGj3I+YdfISl8Uu5CEiz9YyJgHCgQi5CLPBvPQ4WyI+1JbfYJol2ADM2PzAvo7Jf
	nRLkgoHfhk2LsXkz51poBgbMAaf8r9TT5odsjCQT9pq430u3TCbZiW3YRsfkZtWwzQISahH+jWV
	m3Nqq9l+1UVdfXa4S0RooPjdVO4lfoy+ZP9D
X-Received: by 2002:a05:622a:2519:b0:50e:2b1e:9d14 with SMTP id
 d75a77b69052e-50e2b1eb0d4mr28274851cf.29.1776350651371; Thu, 16 Apr 2026
 07:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408172510.52950-1-joannelkoong@gmail.com>
In-Reply-To: <20260408172510.52950-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Apr 2026 16:43:59 +0200
X-Gm-Features: AQROBzAJ6jKrtMdHiBfUtDdqaZH4zd4thBXdfD61RInP-ruugcy9ZnnLnkVHGHI
Message-ID: <CAJfpegungbDJ57MJnLACuzKEqCDOBgPH0WzZ+9Pt3FJHDaCBGQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix io-uring background queue dispatch on
 request completion
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bernd@bsbernd.com, hbirthelmer@ddn.com, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238320-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 05DA440FB91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 at 19:28, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> When a background request completes via the io_uring path, the
> background queue gets flushed to dispatch pending background requests,
> but this is done before the connection-level background counters
> (fc->num_background, fc->active_background) are properly accounted,
> which may reduce effective queue depth to one.
>
> The connection-level counters are decremented in fuse_request_end(), but
> flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
> the io_uring per-queue bg one, which means pending uring background
> requests on the queue are never dispatched in this path.
>
> Fix this by accounting the connection-level background counters first
> before flushing the queue's background queue. Since
> fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
> skip the background cleanup branch entirely, which avoids any
> double-decrements; it will call the wake_up(&req->waitq) branch but this
> is effectively a no-op as background requests have no waiters on
> req->waitq.

Does this guarantee progress if there are still requests on
fc->bg_queue at the point when ring becomes ready?

Seems so, because there must be at least one background request on the
regular request queues if bg_queue is non-empty, and when that is
finished, a new one will be put on the pending queue, and so on until
bg_queue becomes empty.

Maybe add a comment about this subtlety?

Thanks,
Miklos

