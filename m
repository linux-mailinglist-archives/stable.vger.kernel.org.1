Return-Path: <stable+bounces-35675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A6A8964D8
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 08:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFF1F2330B
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B117C64;
	Wed,  3 Apr 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4bw69Mc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062601757A
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126948; cv=none; b=HlGReGCmHv4E/ST5FohllMmVaGgdNZblZNPs2mkjxyJFYnSK6AxYDdLGJpTlDvQTo/25luCFbUcHYZKC7IjEBnZA8mP2UQiYgBpWcREn/Ld8pq+3+x7GcgUkAINlzyYk4BnTZJ4O5b0l2nJv11iOT14wmqvIVsPy4tZTeAS+Xu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126948; c=relaxed/simple;
	bh=Hc32XsXTiOiAZAk1wzP5TaLJmjS8QG0YId6ztoOkC+w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qXbK7hqzklMIqoLDtAPlW8N/g4pACvS6bSbiThY2TrG4be0pJodViJiT8YbBqhHg7j0WO1Tu25WqeoNtBLs9OVOSs8pLzorZX4N870H9lvmVHoP7xV9aNZ/0c/Il23rUR4EKKaxBGSg7iNlF2IYxD4vlA+m/DFRdSh5O5OYi1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4bw69Mc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso8784886a12.2
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712126945; x=1712731745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ngJ5UYt9SKlT6saxHknsrt2d0sXpyYKWRs8/VSUtHVk=;
        b=S4bw69McdEQ7c2Zh27sr4nJS53/8cl03B5sS1nRvm+Mg4DP6gzfDvLijTKJULCp5ol
         /jTqYBmIJ1ktF2uEiecFdfRnSBBOH1OBfq4lJezJsV9zD/TRDB8dN1e6Am4GrD2DvOk0
         2ZjPpnNLm0Bw0HYU1qHpqOV8WJnHIl2O5w0QFNwCx5mEI3dh3LUjEa9s8IWRa/hv9I9g
         Obhd3X/iTkh0UZL9O0UKvgcMqmqkExAGvNizyUQ/2Cou217Ihkcek0S0209yiinqP51J
         YdFWTm2nTGw6/kVOBCLi+n31lgM50HvAxRnNNAq20SBnHB//W8/On+Xz4gUjiXrQ4z5R
         KitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712126945; x=1712731745;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngJ5UYt9SKlT6saxHknsrt2d0sXpyYKWRs8/VSUtHVk=;
        b=Kqp3Mpfx0HksPqVK53WQh9Yld1/rVrKhcDHbR/CB/usPP8zeH4MvbUWJ4/izRpw0te
         xMu5XEiKHqra4PfGi1tGEl8RRsdruYbvjYoYGlnQJ5kwhk1xE81M1Tn8QLDEcVzjiWCn
         iWBwfQhGOqrDXtCo7Vs4axSxH/2z09twJPbaIrfXkt+3W1LbrDJsCryte7W+JJba/k7/
         ZW9n+OiXgseCCAyiIvPLBlkUG1RjQtBsl+sfutIGx9KcRjjOxpIezFm2fG21NtiTt5RZ
         ThviNNF0iZntVaMI7VzleHMXZCe/yLhJC86gYlaHuY5rNZMjbWyXY26DLhToeVwCTD3O
         ImMQ==
X-Gm-Message-State: AOJu0Yxc+J6ZxXN77vsd1WBLdSBGITi7QwiTBswYHUCWqfB8hHBxZze1
	il8LzyDFsqE+Y9Qc4MhCeDGA+gDp4Kjbch2wAAdHvHV0SMTDTf8Fh5Xt6Ff5JjOR2jPly/kJ1u1
	GwYNNaRnL3kr7KIgKSjYNEvQ0H3V2PiWl+xc=
X-Google-Smtp-Source: AGHT+IH2ZNKurN3f8+36r2ripMVJPL8DpU26g28oRTjRGbzaKBcN/jd5zR+pV7BpZyySMqjvlaGQK7SycQYzpvfwvxA=
X-Received: by 2002:a17:907:1b21:b0:a4e:3715:7f4a with SMTP id
 mp33-20020a1709071b2100b00a4e37157f4amr11773768ejc.71.1712126944990; Tue, 02
 Apr 2024 23:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 3 Apr 2024 12:18:53 +0530
Message-ID: <CAFTVevX6Yzjm40EoGZzex6G-f3T-YNG2CZMAuy=fBSwx9hm8Jw@mail.gmail.com>
Subject: Requesting backport for 71f15c90e78 (smb: client: retry compound
 request without reusing lease)
To: stable@vger.kernel.org
Cc: Steve French <smfrench@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, bharathsm@microsoft.com, 
	Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

commit 71f15c90e785d1de4bcd65a279e7256684c25c0d upstream
smb: client: retry compound request without reusing lease
requesting backport to 6.8.x, 6.6.x, 6.5.x and 6.1.x

This patch fixes a potential regression  (eg. failure of xfstests generic 002
and 013) that is introduced by patch 1 of this patch series:
https://lore.kernel.org/stable/CAFTVevWEnEDAQbw59N-R03ppFgqa3qwTySfn61-+T4Vodq97Gw@mail.gmail.com/
commit 2c7d399e551ccfd87bcae4ef5573097f3313d779
(smb: client: reuse file lease key in compound operations)

As per MS-SMB2, lease keys are associated with the filename. The smb client
maintains lease keys with the inode. Consequently, if a file has hardlinks,
it is possible that the lease for a file be wrongly reused for an operation on
its hardlink or vice versa. In cases such as this, the rename, delete and
set_path_size compound operations that reuse the lease key (courtesy of patch 1)
fail with STATUS_INVALID_PARAMETER.
This behaviour (and the fact that lease keys are being associated with the inode
and not the filename) was being concealed by the lease breaks issued after
each of the mentioned compound operations (even on the same client) since the
lease was never being reused. Hence, the fix becomes important.

Thanks
Meetakshi

