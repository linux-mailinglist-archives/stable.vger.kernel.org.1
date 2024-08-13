Return-Path: <stable+bounces-67501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A1A95083D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DD31C22AB8
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03A19F47E;
	Tue, 13 Aug 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AWqzQhF4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x9u3nK7R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AWqzQhF4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x9u3nK7R"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180519E81D;
	Tue, 13 Aug 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560802; cv=none; b=bPseGMSQO5AWxPPBIdhl4xaGhWGzHLTy3r8KmTKxV98vIk2vePbI4azZRj+hbuo2dOrRFWnnuSC67R5bOXskSzxZCJ3Zu7borTCmeSfkiojM66pzb726ZWmxKVj6wKSia/4ZHm1+wzBgbANMiFUypAJQ4ODz4rM7U5AldCLMGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560802; c=relaxed/simple;
	bh=yMmxOIE70gQEb8EngiMix+pWEJx49tnW87g1edmKyGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yg3NX5s/fck5by2UxL2/hp7WRQF2QWNuL2FBmqoychDw0VVT2gi+g8/QFpIckdqwsPYgCh4Ab1rhr6Xi5rp4cgyZ+qRfa+7WAriK93vRSleYIoEprWGsZfUgg2dJrrShHy0cLuYJCwiT6tllApzSPIqUIKjA13aC7HcTkUJfUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AWqzQhF4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x9u3nK7R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AWqzQhF4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x9u3nK7R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1035A203CC;
	Tue, 13 Aug 2024 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723560799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEYe10O9+hY8k7vPvVeZrwFGn8s+N1dK35HhHPc/FiE=;
	b=AWqzQhF4BVnbDPCnJCxT9i7eCLIAydfYALqWXlAYdo3EZiLSkgoVvGNMw8qqX6dympdZs4
	Zq86GkR+gjWD1KCAhq8bIJvpxhvFFnb8Z2EPi/q1zZqu+xemEckxDTuhTh7Uy3mVzvbp2e
	zg4+JpmtKGB4Hwj+66wQ1t/kzn9mG2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723560799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEYe10O9+hY8k7vPvVeZrwFGn8s+N1dK35HhHPc/FiE=;
	b=x9u3nK7RUviZjw8Tak5UwyQfm3wXyHHJ0gHBEXWWnvLJ5NEeKm0TTvd/sMGQJaqQx0VRwV
	dSwEkWa6ECqj5EBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723560799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEYe10O9+hY8k7vPvVeZrwFGn8s+N1dK35HhHPc/FiE=;
	b=AWqzQhF4BVnbDPCnJCxT9i7eCLIAydfYALqWXlAYdo3EZiLSkgoVvGNMw8qqX6dympdZs4
	Zq86GkR+gjWD1KCAhq8bIJvpxhvFFnb8Z2EPi/q1zZqu+xemEckxDTuhTh7Uy3mVzvbp2e
	zg4+JpmtKGB4Hwj+66wQ1t/kzn9mG2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723560799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEYe10O9+hY8k7vPvVeZrwFGn8s+N1dK35HhHPc/FiE=;
	b=x9u3nK7RUviZjw8Tak5UwyQfm3wXyHHJ0gHBEXWWnvLJ5NEeKm0TTvd/sMGQJaqQx0VRwV
	dSwEkWa6ECqj5EBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96CF613983;
	Tue, 13 Aug 2024 14:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eoncIV5zu2bhMQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Aug 2024 14:53:18 +0000
Message-ID: <ff94519d-fa05-42f8-8833-a8c35d542ae4@suse.de>
Date: Tue, 13 Aug 2024 16:53:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ata: libata-scsi: Honor the D_SENSE bit for
 CK_COND=1 and no error"
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Igor Pylypiv <ipylypiv@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
 Stephan Eisvogel <eisvogel@seitics.de>,
 Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org
References: <20240813131900.1285842-2-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240813131900.1285842-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/13/24 15:19, Niklas Cassel wrote:
> This reverts commit 28ab9769117ca944cb6eb537af5599aa436287a4.
> 
> Sense data can be in either fixed format or descriptor format.
> 
> SAT-6 revision 1, "10.4.6 Control mode page", defines the D_SENSE bit:
> "The SATL shall support this bit as defined in SPC-5 with the following
> exception: if the D_ SENSE bit is set to zero (i.e., fixed format sense
> data), then the SATL should return fixed format sense data for ATA
> PASS-THROUGH commands."
> 
> The libata SATL has always kept D_SENSE set to zero by default. (It is
> however possible to change the value using a MODE SELECT SG_IO command.)
> 
> Failed ATA PASS-THROUGH commands correctly respected the D_SENSE bit,
> however, successful ATA PASS-THROUGH commands incorrectly returned the
> sense data in descriptor format (regardless of the D_SENSE bit).
> 
> Commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for
> CK_COND=1 and no error") fixed this bug for successful ATA PASS-THROUGH
> commands.
> 
> However, after commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE
> bit for CK_COND=1 and no error"), there were bug reports that hdparm,
> hddtemp, and udisks were no longer working as expected.
> 
> These applications incorrectly assume the returned sense data is in
> descriptor format, without even looking at the RESPONSE CODE field in the
> returned sense data (to see which format the returned sense data is in).
> 
> Considering that there will be broken versions of these applications around
> roughly forever, we are stuck with being bug compatible with older kernels.
> 
> Cc: stable@vger.kernel.org # 4.19+
> Reported-by: Stephan Eisvogel <eisvogel@seitics.de>
> Reported-by: Christian Heusel <christian@heusel.eu>
> Closes: https://lore.kernel.org/linux-ide/0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu/
> Fixes: 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


