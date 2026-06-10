Return-Path: <stable+bounces-262537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sS5dHSeSKWpOZwMAu9opvQ
	(envelope-from <stable+bounces-262537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:34:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6DE66B85A
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:34:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=crudebyte.com header.s=kylie header.b=cTJA+mxY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262537-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262537-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=crudebyte.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1F4930F0D7A
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167A33689E;
	Wed, 10 Jun 2026 16:25:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2931F9A2;
	Wed, 10 Jun 2026 16:25:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108741; cv=none; b=mG+Wt7JtaHca991jaXtLkRhmCaQiyU7GH4txcMZx3yt31PfogcxfT9Sn9UtVQZuK/pyJvDBZ5/NPU1eHgzj8udNwIp8YS3Iu9OIKhHlf7lTmC6WPBAhfkXZ53Xn40eu112XfWZ/X2oLh9dV55X9ZlGcysbZgtQL5rO3UpLzk4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108741; c=relaxed/simple;
	bh=htM2khgHfnUWMbxF5QO2EKmsTuEgphGXBdpgWSrVaMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZrCtoWLkszv/1rYQFqCpVLiU8ScU7Viar6C82d+/eojS30sy0ozICjvaDoZe54hEKhDF1qJgAcfOxScdpFG6/N9a19DpV2wOcPpOLxfW1DEjBNaVIfMZJ0IKNhYKTjRmtSa1n2j6KwStXzYSbQhRCIGsl/u/BvKBX00dfgMR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=cTJA+mxY; arc=none smtp.client-ip=5.189.157.229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=KfS3ig5mGkyyFPWW4cNnCQUNTT0//5Cf3AvgXx33nes=; b=cTJA+mxYjbBuaNXV0SH0a+A6jL
	smB44HSPEerkEBSBM6zbvzNWyP1oBLeY65DKP4tlyiA4v3/I2TsLGb6kGOusZC+oKQTIATfkDOtZF
	BC0vhqReWRlQEGzE9BxUG3jEHTUTOtm3oxGXBO+mor6haVWdyIhcw3PNnV3okahmBIEngTxH/30oA
	daJ6DPmStx59GaXzgN4ARaR/4KCam5nk973OCaZDaYG0iqOKlvISaG5i0w5SiBiTJa2guG6wqWmGD
	RKW6aBzLtlsXy6165oTAMEExNOcZKYjdgfuByKfDwFA1vGU0FTwKNqdyIi04luJv+UmW785o/CCl6
	4pDwBLhLjEHEQEsdaQ4b3VyODUoAanUG/WvWi4wPvi2FbW69MjOhVEH5/ozWPr6S5tVwLvgeJ0d9N
	gybbDJCPTlccA5CYyZiqo3RC6kT+eYk+ry+2tWc/QTqrGXgZQ7tLutTrKejTMf5M8VsCDiU3rCPY6
	FB5aVRu/0TSUnlSKqi+SClXC0/uSFBaQDFDXapPdjy/je8W9PHkYYbaSPTreXiIGNr3rgT1+iOIX7
	/UHFybMlScO3JYE1tZUjVHYcStaXzYuuBO/u82CK+C4SSof20BtimM4bHssryD+ZjVz76NIREwTXu
	iTbbqWWrryQkoljrMGI0e1WDEttJSs+xX+PaB1DOw=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: v9fs@lists.linux.dev, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] 9p/trans_virtio: bound mount_tag show copy to one page
Date: Wed, 10 Jun 2026 17:46:13 +0200
Message-ID: <1962500.CQOukoFCf9@weasel>
In-Reply-To: <20260610114206.3749904-1-michael.bommarito@gmail.com>
References: <20260610114206.3749904-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262537-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,ionkov.net,codewreck.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ericvh@kernel.org,m:lucho@ionkov.net,m:asmadeus@codewreck.org,m:michael.bommarito@gmail.com,m:v9fs@lists.linux.dev,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linux_oss@crudebyte.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,crudebyte.com:dkim,crudebyte.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C6DE66B85A

On Wednesday, 10 June 2026 13:42:06 CEST Michael Bommarito wrote:
> p9_mount_tag_show() copies strlen(chan->tag) + 1 bytes into the
> single-page buffer the sysfs core provides, with no upper bound. The
> mount tag length comes from virtio_9p_config.tag_len, a 16-bit field read
> from the device at probe in p9_virtio_probe() with no cap. Under the
> confidential-computing threat model, where the guest does not trust the
> host, a malicious or compromised host can present a 65535-byte tag with
> no embedded NUL. A read of the world-readable /sys/.../mount_tag
> attribute (udev reads it at probe) then copies ~64 KiB into the 4 KiB
> sysfs page, a slab-out-of-bounds write of host-controlled content.
> 
> Bound the copy to the page size in the show handler.
> 
> Fixes: 179a5bc4b8cb ("net/9p: use memcpy() instead of snprintf() in
> p9_mount_tag_show()") Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/9p/trans_virtio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 4cdab7094b273..b62aa7b309f1c 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -573,7 +573,11 @@ static ssize_t p9_mount_tag_show(struct device *dev,
>  	chan = vdev->priv;
>  	tag_len = strlen(chan->tag);
> 
> -	memcpy(buf, chan->tag, tag_len + 1);
> +	if (tag_len > PAGE_SIZE - 2)
> +		tag_len = PAGE_SIZE - 2;
> +
> +	memcpy(buf, chan->tag, tag_len);
> +	buf[tag_len] = '\0';
> 
>  	return tag_len + 1;
>  }

Given that this has already seen some rotations, it is worth to think a bit 
more about it:

1. Destination buffer being PAGE_SIZE large is an implementation detail of 
seq_file. If the latter is changed, this code breaks (again) silently without 
anybody noticing.

2. memcpy() was introduced by 179a5bc4b8cb because chan->tag was not NULL 
terminated. However since edcd9d977354 it *is* NULL terminated.

Given those two, an alternative would be:

  len = sysfs_emit(buf, "%s", chan->tag);

As it already handles the PAGE_SIZE limit inside its implementation.

However, still ...

3. Is it a good idea to just *silenty* truncate a very long tag to something 
else just to avoid an OOB? It would at least break auto mount rules, as the 
truncated tag would not match device's real tag.

4. And most importantly: Would a sane 9p device *ever* use a 64k tag, if yes 
what for?

I would say no, a 64k tag is at least suspicious, if not even hostile.

Therefore: what about simply rejecting the device at probe time if its tag is 
beyond a certain length?

/Christian



