Return-Path: <stable+bounces-231180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAVRHaFkymn27gUAu9opvQ
	(envelope-from <stable+bounces-231180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:55:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F135AA97
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EBF7300AB3D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A13CA488;
	Mon, 30 Mar 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z40VBc3L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/6ifK3ft";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z40VBc3L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/6ifK3ft"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EEB3C9452
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871248; cv=none; b=M0+rUKLJgRFGFlWmuKc2q6jDh6GE7JNx4fftZLcCdC+W9xvvsBeeUaAJLUBMTKKvNI8xzOMk9J4Qn97p9oB/r64NVeny9NLrcjoFJAz2rGt9yZfs/B6Uc7mMe4IVcaVlyL1gq3a1x+XvLdpp2eT+qtqwoTPkW2XxhIOIwR3LIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871248; c=relaxed/simple;
	bh=e1SZeR/5FcqTiIeQPnwssueomtYyGOfL7VZKRujztsw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYj4HwcaNt/3mMmdRr3ETfLVrhVGq4ZGPWG3HhVP84ncxZAo60QoL13yZjh7/2QVd6ij32pXcLTjD4MKF+akRupv5Ur6zwCkHHtepgHLiin3x/cAviL9qS2eBsw1GFc609HY9z/aU9m9iTVL+CUzm82iy9JXxGHZMqn1OwN5r1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z40VBc3L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/6ifK3ft; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z40VBc3L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/6ifK3ft; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A16685BD39;
	Mon, 30 Mar 2026 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774871245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGkNKNx6/57YqNRE5ARl4bzqmmM1DrRENKndswg/PP8=;
	b=Z40VBc3LJJIcCosT0W0NM2p7HSFdC46+lojJCbEL+kx7tsB9d2YY2KjmbARwqWV82joLle
	VrWBhT5OPOYtVAgk/YlsxKqKU+WHO8Uj9rQ4wCukeEBQ7zqWoCmfNvhfk0LxS2eQ8JStHb
	Rg+aFojNRnM5hnAQIqs1xf9K1wCrdQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774871245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGkNKNx6/57YqNRE5ARl4bzqmmM1DrRENKndswg/PP8=;
	b=/6ifK3ft9tgmrFrxIN/HJUl+ryG2NknQZgUOKs06IUzE+HU5vu4Lwk4Ix0toMHuzmW0rGt
	zFVImJNXJ9x/vJBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z40VBc3L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/6ifK3ft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774871245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGkNKNx6/57YqNRE5ARl4bzqmmM1DrRENKndswg/PP8=;
	b=Z40VBc3LJJIcCosT0W0NM2p7HSFdC46+lojJCbEL+kx7tsB9d2YY2KjmbARwqWV82joLle
	VrWBhT5OPOYtVAgk/YlsxKqKU+WHO8Uj9rQ4wCukeEBQ7zqWoCmfNvhfk0LxS2eQ8JStHb
	Rg+aFojNRnM5hnAQIqs1xf9K1wCrdQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774871245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGkNKNx6/57YqNRE5ARl4bzqmmM1DrRENKndswg/PP8=;
	b=/6ifK3ft9tgmrFrxIN/HJUl+ryG2NknQZgUOKs06IUzE+HU5vu4Lwk4Ix0toMHuzmW0rGt
	zFVImJNXJ9x/vJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74A204A0A2;
	Mon, 30 Mar 2026 11:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /UM6G81iymmeMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Mar 2026 11:47:25 +0000
Date: Mon, 30 Mar 2026 13:47:25 +0200
Message-ID: <874ilxv8s2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: hda/realtek: Add quirk for ASUS ROG Strix SCAR 15
In-Reply-To: <20260330075334.50962-2-zhangheng@kylinos.cn>
References: <20260330075334.50962-1-zhangheng@kylinos.cn>
	<20260330075334.50962-2-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231180-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: D06F135AA97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 09:53:34 +0200,
Zhang Heng wrote:
> 
> ASUS ROG Strix SCAR 15, like the Strix G15, requires the
> ALC285_FIXUP_ASUS_G533Z_PINS quirk to work properly.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221247
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied this one for now.  Thanks.


Takashi

