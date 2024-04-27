Return-Path: <stable+bounces-41541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087898B4340
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 02:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395C21C22DF5
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 00:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC563D5;
	Sat, 27 Apr 2024 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JutZg4ZP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0A5228;
	Sat, 27 Apr 2024 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177742; cv=none; b=PVVbwTQxeGtEL9Tt/WT9gWH6JFBfTHvd5LDgLXr2w9cnqzD+HD8erbP2Bxx6TF45xRx1MlvAVbK9m1PRFFTT2aSa3QUFr9LP2/NRrDqVJqVdmp+QV6+t8aEIyqM+dc0FzcJc9fae8UBINTGzLp6iQgBeKKPvP0u4kLXRmCFQl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177742; c=relaxed/simple;
	bh=z1iMTSz1FTF5BHvEhJcPUplkaY3m40Swft0M6ZuTjHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WJl9nL96xEayc1axC2MZFRrwM2yJ8eA9ypHWrUV5AszNkhQFj/89xmRdYt9GQWwMu229VBH6AjpWSLjXwT7YSBcOUrrBgE3+tzRR4wxstG02FkeYMhCvFm6ZDaffykoE6YXdgSW7nbQh2PQFV+IH4wFF71raDx+hsOgseiRkdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JutZg4ZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010F6C113CD;
	Sat, 27 Apr 2024 00:29:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JutZg4ZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1714177738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4fd0jz0BChpMTIBqWSjkXJP2P2W/5oQ39jqPV6RAj1M=;
	b=JutZg4ZPNYap5BiToHwX3apwyIjL638iO+h5ggoieLWJB0BbIpgZKrhfS8cBpDQuxXUCQ2
	0IvPuUxrKpI5zQO5LrQZNCv1AJxIO8aRp/vcMVok1llKkZH1lgcUhyidE2WjM4Pbi0ibyb
	np5WSOqgv1IDm51c8KSOwoyP82IVdvM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b137cfa1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 27 Apr 2024 00:28:58 +0000 (UTC)
Date: Sat, 27 Apr 2024 02:28:55 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tools@linux.kernel.org, stable@vger.kernel.org, meta@public-inbox.org
Cc: sashal@kernel.org, gregkh@linuxfoundation.org, mricon@kernel.org,
	krzk@kernel.org
Subject: filtering stable patches in lore queries
Message-ID: <ZixGx_sTyDmdUlaV@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Greg and Sasha add the "X-stable: review" to their patch bombs, with the
intention that people will be able to filter these out should they
desire to do so. For example, I usually want all threads that match code
I care about, but I don't regularly want to see thousand-patch stable
series. So this header is helpful.

However, I'm not able to formulate a query for lore (to pass to `lei q`)
that will match on negating it. The idea would be to exclude the thread
if the parent has this header. It looks like public inbox might only
index on some headers, but can't generically search all? I'm not sure
how it works, but queries only seem to half way work when searching for
that header.

In the meantime, I've been using this ugly bash script, which gets the
job done, but means I have to download everything locally first:

    #!/bin/bash
    PWD="${BASH_SOURCE[0]}"
    PWD="${PWD%/*}"
    set -e
    cd "$PWD"
    echo "[+] Syncing new mail" >&2
    lei up "$PWD"
    echo "[+] Cleaning up stable patch bombs" >&2
    mapfile -d $'\0' -t parents < <(grep -F -x -Z -r -l 'X-stable: review' cur tmp new)
    {
      [[ -f stable-message-ids ]] && cat stable-message-ids
      [[ ${#parents[@]} -gt 0 ]] && sed -n 's/^Message-ID: <\(.*\)>$/\1/p' "${parents[@]}"
    } | sort -u > stable-message-ids.new
    mv stable-message-ids.new stable-message-ids
    [[ -s stable-message-ids ]] || exit 0
    mapfile -d $'\0' -t children < <(grep -F -Z -r -l -f - cur tmp new < stable-message-ids)
    total=$(( ${#parents[@]} + ${#children[@]} ))
    [[ $total -gt 0 ]] || exit 0
    echo "# rm <...$total messages...>" >&2
    rm -f "${parents[@]}" "${children[@]}"

This results in something like:

    zx2c4@thinkpad ~/Projects/lkml $ ./update.bash
    [+] Syncing new mail
    # https://lore.kernel.org/all/ limiting ...
    # /usr/bin/curl -gSf -s -d '' https://lore.kernel.org/all/?x=m&t=1&q=(...
    [+] Cleaning up stable patch bombs
    # rm <...24593 messages...>

It works, but it'd be nice to not even download these messages in the
first place. Since I'm deleting message I don't want, I have to keep
track of the message IDs of those deleted messages with the stable
header in case replies come in later. That's some book keeping, sheesh!

Any thoughts on this workflow?

Jason

