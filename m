Return-Path: <stable+bounces-5258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7DB80C283
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 08:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D692C1F20F90
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53D20B02;
	Mon, 11 Dec 2023 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F2EXEQKF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVxx0YFR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F2EXEQKF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVxx0YFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F3CD;
	Sun, 10 Dec 2023 23:59:10 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B90D1FB6C;
	Mon, 11 Dec 2023 07:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702281549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uu6n7mEvnmXbniOla3rPuD+at6mp806bEoBZqpe8Srs=;
	b=F2EXEQKFjaL8rqwVqqdQBU9hMTkZcxVRfsFW6uSowHHxfUb6IKM5rUc5vyH1u+nz5Gu0Qy
	c40XaN2A62IIVciP3J+v37MzCtnwTQTQaolpzUO8jfCwFudytNhcgJgDPymwqHGUXV0Gum
	IS1xPDJ7lZgF1CpgSe05vGUPx5oATRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702281549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uu6n7mEvnmXbniOla3rPuD+at6mp806bEoBZqpe8Srs=;
	b=ZVxx0YFRxMokq+KnjclNVrUIaH9LdO+mntagvBMf6y1V//puLAuAZW+AxTunPqt8UsfUr6
	BsAvAzr9si24LnAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702281549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uu6n7mEvnmXbniOla3rPuD+at6mp806bEoBZqpe8Srs=;
	b=F2EXEQKFjaL8rqwVqqdQBU9hMTkZcxVRfsFW6uSowHHxfUb6IKM5rUc5vyH1u+nz5Gu0Qy
	c40XaN2A62IIVciP3J+v37MzCtnwTQTQaolpzUO8jfCwFudytNhcgJgDPymwqHGUXV0Gum
	IS1xPDJ7lZgF1CpgSe05vGUPx5oATRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702281549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uu6n7mEvnmXbniOla3rPuD+at6mp806bEoBZqpe8Srs=;
	b=ZVxx0YFRxMokq+KnjclNVrUIaH9LdO+mntagvBMf6y1V//puLAuAZW+AxTunPqt8UsfUr6
	BsAvAzr9si24LnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE16D132DA;
	Mon, 11 Dec 2023 07:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UcQTMUzBdmXlHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 11 Dec 2023 07:59:08 +0000
Date: Mon, 11 Dec 2023 08:59:08 +0100
Message-ID: <874jgp5fw3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: handle missing EFI calibration data
In-Reply-To: <f1f6583bda918f78556f67d522ca7b3b91cebbd5.1702251102.git.soyer@irl.hu>
References: <f1f6583bda918f78556f67d522ca7b3b91cebbd5.1702251102.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Score: -3.10
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.09
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.17)[-0.867];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.81)[99.19%]
X-Spam-Flag: NO

On Mon, 11 Dec 2023 00:37:33 +0100,
Gergo Koteles wrote:
> 
> The code does not properly check whether the calibration variable is
> available in the EFI. If it is not available, it causes a NULL pointer
> dereference.
> 
> Check the return value of the first get_variable call also.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Call Trace:
>  <TASK>
>  ? __die+0x23/0x70
>  ? page_fault_oops+0x171/0x4e0
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? schedule+0x5e/0xd0
>  ? exc_page_fault+0x7f/0x180
>  ? asm_exc_page_fault+0x26/0x30
>  ? crc32_body+0x2c/0x120
>  ? tas2781_save_calibration+0xe4/0x220 [snd_hda_scodec_tas2781_i2c]
>  tasdev_fw_ready+0x1af/0x280 [snd_hda_scodec_tas2781_i2c]
>  request_firmware_work_func+0x59/0xa0
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> CC: stable@vger.kernel.org
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thanks, applied now.


Takashi

