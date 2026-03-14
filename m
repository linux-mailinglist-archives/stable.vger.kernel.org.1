Return-Path: <stable+bounces-225409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5SM5G9z5tGmCvAAAu9opvQ
	(envelope-from <stable+bounces-225409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 07:02:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86328BD72
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 07:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADA103041151
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 06:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26093009EE;
	Sat, 14 Mar 2026 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qsaHRV9A"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D041175A8F;
	Sat, 14 Mar 2026 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773468116; cv=none; b=NXaPiQsSm04MCv+sNtXmfL6+EHr8q9HEt3xkf5fr75l+YRWiVyI4lhsL28jpLCaaI6ohQ1smqwS1MPEWch2Q+1627Dy4AKjQ3SU9EpB2cbYaZ1XcXQ9L7sQL1BI6TRgG2qSB2HCy0mTOPPCOdQelDrKQKAtoiY5eKmDA+JEI0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773468116; c=relaxed/simple;
	bh=AvtvzcdCSVbGsbjHwimwreG7EVSCVEoOn7iAeppjrkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJywFVtdwhnWw4dyV7KvBhq/O2vCjA7KrlvXqRBzrFX4u7I7vnCaZuhmRXq0+pyi3bo0mYIyxcn6eOPQ8yFAltU54nHbseEn5OtDDAC+Obm2vXPNm9CbQXJUnUhppc9ZkAtmP9xZFGQv4uc5IY5NkqQUe4rpejmt0o3FSuEgmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qsaHRV9A; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6F6AD14C2D6;
	Sat, 14 Mar 2026 07:01:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1773468105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcp67iuIViZsl+G1DOnI57D0svrPqokbvFTenZiv2zw=;
	b=qsaHRV9AWokT7+tqd8VDzCQgQq7UfFbdMuZbWfeIxDmU+ZXol1eMN0buMEdNoxHLmvKp77
	rVyRNCXXYZeGfjUG6WMpr+dL3rcelriWLSz+pm9aEsNs2NCnPiYoRucqzaM4PmnGj7Dg+0
	rq9gD8Le0iOlyEVuilljAixs5OZ2ZqdweGm4qICaf6izC0tM3W78T78OqLcUwzFMFpi2PW
	krVaLbonF52GLGzVSl4rO8r56GoxbTl19kapU8974CpK4zs0EZ4sGFZgtrHs4jYSsMgRrL
	XdSvNGHDL6NEijfTdqf/YxtPjDkbBwtH5aZOjeeuZndfnPkszsMaeyfMhW81Kw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9d694874;
	Sat, 14 Mar 2026 06:01:40 +0000 (UTC)
Date: Sat, 14 Mar 2026 15:01:25 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org,
	v9fs@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <abT5tabfYV9a9RF_@codewreck.org>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313171659.1225180-1-jhj140711@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[codewreck.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225409-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE86328BD72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hyungjung Joo wrote on Sat, Mar 14, 2026 at 02:16:59AM +0900:
> p9_usbg_close() tears down the client transport, but usb9pfs keeps
> using usb9pfs->client from asynchronous TX and RX completion handlers.
> A late completion can therefore dereference a client that has already
> been freed during mount teardown.
> 
> Clear usb9pfs->client under usb9pfs->lock when closing the transport,
> detach any pending TX request from in_req->context, and make the TX/RX
> completion handlers bail out once the transport has been detached. This
> keeps late completions from touching a freed or rebound p9_client.

Just to make sure the problem is the usb9pfs struct being freed, not the
p9_client itself which is still alive after the usb device is gone
(until umount)?

I'm surprised free_func isn't called after unbind, which should stop the
queues (through disable_usb9pfs)?
or are the ep being disabled not enough to ensure the callbacks are not
in use? (e.g. disabling prevents further calls, but doesn't wait for
currently running/queued requests?)


(Also, thanks Michael for looking -- I'll let you do a first review
before looking deeper)
-- 
Dominique

