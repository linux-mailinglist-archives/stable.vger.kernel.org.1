Return-Path: <stable+bounces-223008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NcMOXPhp2mrlAAAu9opvQ
	(envelope-from <stable+bounces-223008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:38:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110F1FBB12
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E009303A245
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F1371056;
	Wed,  4 Mar 2026 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tSSFAMCp"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2FE30ACF0
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609799; cv=none; b=tgOoIkuIu630AdMXKmkifLTutbztCw0hk7SRY7T328UjZiG+vxLM4xRdCdcJRFEBvPNv4a7BKEBJqdv0Lg3YB56x5Fu5IzTdWdee8OoQ9IWh8Q5MR0rBHiHuKZYGtR5tWLKwmi4f70QfGtxpUFgAMlXo5Ov5RtWkhYtImhzht9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609799; c=relaxed/simple;
	bh=+PPCeHP33qvofEgSpuMY+ASCX/FXcAPOF9YknZCof3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=cl9UVzNmfTBzop2fqp7PFsCOokvAITSTEHXfAakrsW2+S6cBpibs7rhzeiwDRAzmPeWJIbnRsaZuav+105p+IMG4K8JzzFuyV5IPx4O/7jdLekzwW7HWtqmtrXzoieJcJJaqnLQn5rWTSjS7NZu1TJAdn0coC9zvq58JvfuQHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tSSFAMCp; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260304073627epoutp019a81cc22288e4a176cf765238f62f621~ZkzWrUq2B1398113981epoutp01q
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:36:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260304073627epoutp019a81cc22288e4a176cf765238f62f621~ZkzWrUq2B1398113981epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772609787;
	bh=+PPCeHP33qvofEgSpuMY+ASCX/FXcAPOF9YknZCof3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tSSFAMCpE9TLihw6ne/cfKmmSI/hv/s9dFUXEbxr5D3DjwZnftfFubVqDYuX4OWEq
	 araChnRBmioQ8sY8v9Ryi58h03wJjd7HAYYOUmeagH5TcCqdzbH2751cS63RpVSF4f
	 UIwyg2xUSJxUppAcKSZ2pwb0N9F2iSo6b3N2rTIA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260304073626epcas5p3f6a8cb566088d737039ce9ffd83ae053~ZkzWBeIO30816108161epcas5p3A;
	Wed,  4 Mar 2026 07:36:26 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fQkxj0zFXz6B9mP; Wed,  4 Mar
	2026 07:36:25 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260304073624epcas5p45099e56c0d1c772b233d03f0cd847ea7~ZkzUNpxt01983519835epcas5p4c;
	Wed,  4 Mar 2026 07:36:24 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260304073622epsmtip139f0fe4255dd6a1be4c1a08abba5f0d5~ZkzSx_EfP1851818518epsmtip1X;
	Wed,  4 Mar 2026 07:36:22 +0000 (GMT)
Date: Wed, 4 Mar 2026 13:01:59 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Jens
	Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-auth: Don't log shared secret in
 nvme_auth_dhchap_exponential()
Message-ID: <20260304073159.olmzwf4xr6gvswut@green245.gost>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
X-CMS-MailID: 20260304073624epcas5p45099e56c0d1c772b233d03f0cd847ea7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----x4gpVB5grIOn2U3qr3muLlEaegkXp-1X2jjZVqcl5_K7UNzi=_68ce0_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260304073624epcas5p45099e56c0d1c772b233d03f0cd847ea7
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
	<CGME20260304073624epcas5p45099e56c0d1c772b233d03f0cd847ea7@epcas5p4.samsung.com>
X-Rspamd-Queue-Id: 4110F1FBB12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223008-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,green245.gost:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nj.shetty@samsung.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

------x4gpVB5grIOn2U3qr3muLlEaegkXp-1X2jjZVqcl5_K7UNzi=_68ce0_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 03/03/26 08:03PM, Thorsten Blum wrote:
>When debug logging is enabled, nvme_auth_dhchap_exponential() logs the
>DHCHAP shared secret. Remove the log to avoid exposing key material.
>
>Fixes: b61775d185a3 ("nvme-auth: Diffie-Hellman key exchange support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------x4gpVB5grIOn2U3qr3muLlEaegkXp-1X2jjZVqcl5_K7UNzi=_68ce0_
Content-Type: text/plain; charset="utf-8"


------x4gpVB5grIOn2U3qr3muLlEaegkXp-1X2jjZVqcl5_K7UNzi=_68ce0_--

