Return-Path: <stable+bounces-233163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAQaBBeNz2mmxAYAu9opvQ
	(envelope-from <stable+bounces-233163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 11:49:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4F392FC9
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CF0530205C3
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28313218B3;
	Fri,  3 Apr 2026 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="NliT+tOQ"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE8311C15;
	Fri,  3 Apr 2026 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209687; cv=none; b=i2Gv+6XrReyc+oiRpWIinxkzXk9kmrdHzTSnl6IOMLDJF/ThYYpZ0QqLoFTSlBXF4G8L4rPlhcPbsRj85m0+OOcW1rv11jUvHYbXcozqxLnsqyP+s48Sqb67K+Te8SrhdvsC+ahQLNMrBEVe3suQIBX+g13jpyrw9Ku3ZumYWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209687; c=relaxed/simple;
	bh=hZPfUWJ1HGXnOZfGV+Oo01fgO9UjF7c9BsY4sTxpTlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jg9BKL2vwWTY/RoGPZT+iaX0malrwr3VMuU7gBf5FnHEVoWVZ7WJOrq4Jr33CcOweC7O4av07FT0EGpiD7imPc/P5oT4O4wGCTeiIBqnn9YMK8wokB/bQLvHG84PDO7ZyVEnvrbP9ggHvNlYqGYETF1rJTjJOmRUuMktqutvIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=NliT+tOQ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5DFC6406C750;
	Fri,  3 Apr 2026 09:48:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5DFC6406C750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775209683;
	bh=EIa2xY/7ArqmuS4f+LqdW2QQTwVExLr+4F5Vcx6yq0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NliT+tOQj2FTWGMCHPwylQmCn894Tz3Kz7z5FcNXNjHKaGRUos2rQciI0uZON65R7
	 I3aEXVr6HLMHg20QNtY1tu6G1APvWaSNKQidCCJAY7nW2XPBmuPueNAhEcMX/CgCWa
	 aQ6tp3KkjE3TzH/+9hmfc//xwkaZk2d3GOvaRbIg=
Date: Fri, 3 Apr 2026 12:48:03 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Heyne, Maximilian" <mheyne@amazon.de>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>, 
	Peter Wang <peter.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Seunghwan Baek <sh8267.baek@samsung.com>, 
	Seunghui Lee <sh043.lee@samsung.com>, Thomas Yen <thomasyen@google.com>, 
	Brian Kao <powenkao@google.com>, Sanjeev Yadav <sanjeev.y@mediatek.com>, 
	Wonkon Kim <wkon.kim@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 6.1.y v2 0/6] nvme: correctly fix admin request_queue
 lifetime
Message-ID: <20260403124447-fb4fa96a8af4e7117989073e-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402-moral-jockey-f072379b@mheyne-amazon>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233163-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazon.de:email,ispras.ru:dkim,ispras.ru:email]
X-Rspamd-Queue-Id: ABC4F392FC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"Heyne, Maximilian" <mheyne@amazon.de> wrote:
> The initial attempt to backport upstream commit 03b3bcd319b3 ("nvme: fix
> admin request_queue lifetime") was not correct leading to refcount
> underflows and not even fixing the problem.
> 
> I've tested the reproduction steps from [1] (adding a delay to
> nvme_submit_user_cmd and 'echo 1 | sudo tee
> /sys/class/nvme/nvme0/delete_controller') on the nvme-tcp driver which
> printed the KASAN UAF blurb.
> 
> Fixing the issue in the 6.1 series requires a few dependent patches.
> This is mainly the upstream commit 2b3f056f72e5 ("blk-mq: move the call
> to blk_put_queue out of blk_mq_destroy_queue") which allows to move the
> blk_put_queue to a different location.
> 
> The backport of commit 03b3bcd319b3 ("nvme: fix admin
> request_queue lifetime") needed a tweak to the nvme pci driver.
> 
> Furthermore, in this patch series I've also included a follow-up fixup
> from upstream commit b84bb7bd913d ("nvme: fix admin queue leak on
> controller reset"), again with an adaption to the nvme pci driver. This
> issue could easily be reproduced by resetting the controller (no need to
> run full blktests):
> 
>   echo 1 > /sys/class/nvme/nvme0/reset_controller

For the series

Tested-by: Fedor Pchelkin <pchelkin@ispras.ru>

Thanks for the prompt fix.

