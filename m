Return-Path: <stable+bounces-223466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO6oEqbcrWkj8gEAu9opvQ
	(envelope-from <stable+bounces-223466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 21:31:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8688232216
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 21:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B693300DD4B
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1628751B;
	Sun,  8 Mar 2026 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MEN78f/l"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5E63CB
	for <stable@vger.kernel.org>; Sun,  8 Mar 2026 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773001890; cv=none; b=GPsvpYNF5uwYCfZ0NtWVNbLobLr5O43zC4WcIT3SRZ55N2+6XBfAK9gBrJ2A2txeL5AZQ2Zjz98byQHoKdfw3FIIHkaU91n+LFDLXItndbO9F23xN02fzdcsQGyMAr225dVuSVpbY0gqAVvTidgHnysh6rQQ78QxRtiSVKVfS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773001890; c=relaxed/simple;
	bh=WLFGZ2HGOQkqdrAgrIxVS+gh2iIrgJ0Ol9Fu67RXl9E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=MbB0EUDDI1sU7AhYmHwS9BkRSHkv/Au5TJwLaLgHq0o5ur/AlPF23XpzQCKkTeSzOQdv+tsOMDV4F8PIe4UxH31+eIXVQJAZp6XYRa6YCwh7/n9CKm4LdIo080e8xk/JyWQdULnpQeyfXqQTsB69ASw5tahkAF19/7FNjqNtC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MEN78f/l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:Cc:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dHgiz+h+UvHa459Ayh2aXJGwWm8U6G01o89KD05GEDU=; b=MEN78f/lTSd7I92sQM7gAtqKlt
	rdx9/4GxY+aQoBulXFywmSE+/aSs500PwFAq2T15e6ZTfvKWlOpIIdVk0qTGEmPQNsKpZIfBaM7wi
	mo1XXBqucyaekiIkrw974OcTAdMIZv/tqqcfEZTxmgnHYa3ZVTOp383eVvv5T5mEL55icOXdS9c0e
	4d1RJkvUvfNgJxa7XT9Ds5RHjnQGMPnCzqQTFk7aSQviKY36h3XFAY8jtQoUf14CIUM09Wfubym4T
	UIn33onEBj5bjL48KdnG9GCg8CZJ1iATLxintXlPMtsPdIDw1UWkhcXid3qGNpGFP3SioXCIxiamu
	zRbVTPuA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzKmd-00000006Ky7-01hO;
	Sun, 08 Mar 2026 20:31:27 +0000
Message-ID: <ecf1447f-e450-46e7-b3d6-ab4632907492@infradead.org>
Date: Sun, 8 Mar 2026 13:31:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: please pick up patch for v6.19 soundwire build error
Cc: Mark Brown <broonie@kernel.org>, Boris Faure <boris@fau.re>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8688232216
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223466-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,fau.re:email]
X-Rspamd-Action: no action


commit bbb758a6943e
Author: Boris Faure <boris@fau.re>
Date:   Thu Jan 29 14:14:54 2026 +0000

    ASoC: sdca: Fix missing regmap dependencies in Kconfig


for kernel versions 6.19.*
to fix build errors.

I applied it to 6.19.6 and it fixed the build errors that I had.

-- 
~Randy


