Return-Path: <stable+bounces-230359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gASvHKkKxGk+vgQAu9opvQ
	(envelope-from <stable+bounces-230359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:17:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D832A328D46
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8EF6314B85A
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E39D3E5EE8;
	Wed, 25 Mar 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoXYWwbL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/m8H8Cm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F383E4C68
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453587; cv=none; b=t8wFRnBqxIaONZcC8/IvICj7B1doqCC87mKbXBFG05GSkkdHplXeXuGNbjLYLsz0EhULyszjMPW9n87uP9nd1yORNcIix5uCxaE59S48UPc0MzjKU2z7WqGVEC3UWekhijS9eLRAiBnuxYTeiM920hJ5nwEdjpE3J8hVbSbEDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453587; c=relaxed/simple;
	bh=Q26f3s9Ag27BxQHSfba+Y7YQD6BE1ILOOwdbgibPW/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UokH/smk99xa23MyYi8HnxIOH3h5y4XZvS7aG/3kxy0Cp5Oy4YY8jQoOH1FtQehBvqMVOEZzr+I4L+YgU5gmmht4/1unj9fpalk8uR/hVrt9PoHnUcqIFWZdWZ+C52DgzYQgoEl1dLXI7Gpg4NOCGQnKLth24yA4tPqi454w6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoXYWwbL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/m8H8Cm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774453583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7cy/6cDx1rFE8ee3i8hr+hRak5k71ivXO/Y/xfktL8=;
	b=VoXYWwbLfQpAIChJSYgUxQFpV9sRLM/nq+C7yi4XsXHy2I2ESQCi65z3jKKUHoVLnxuuEW
	AxbeU/QBZWZ2gOewH0B9ViNq779B0/muh/xbYUy4B7wHPnbhJBoluxkjgjT4TetKq/wCxz
	NFKW9pPk014uNlPJHudKngcsGJWZsbk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-SOOCpV3kPBmyMGYFK7EbNQ-1; Wed, 25 Mar 2026 11:46:20 -0400
X-MC-Unique: SOOCpV3kPBmyMGYFK7EbNQ-1
X-Mimecast-MFC-AGG-ID: SOOCpV3kPBmyMGYFK7EbNQ_1774453579
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b42eee946so934723f8f.1
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774453579; x=1775058379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7cy/6cDx1rFE8ee3i8hr+hRak5k71ivXO/Y/xfktL8=;
        b=T/m8H8CmTIgCcPSvXhaRpZ5Ppws9Z+qc90UYI4k7LhqfKGqO6G7o8/iSCh8s4Sdqa8
         wwBOLeMi1hRKuwDCJ5H+xgyd6gGmWCFXZ0mY4dJGd1j3d/nPnjVRpiwlXEJy9SwAsDbZ
         3KWDJoI5hGs7sB3tJvgTr2sfCT47CCo6s34OoiG9cva4JpHQpX2qWgkaqnDiwpvEEc62
         4In78JsM69vSZB77wZlt5ixvjCSKwkLtTR4qbyOkFALCI3srO2Hi4ZnXkbR8vh3nqm0R
         zT4vjR/cI+isTcwNBnx9/HMjhqcz5OulY+xZox3lzqN5LpSrbsVOMqQXVcMKrGQ/fGaw
         +iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453579; x=1775058379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7cy/6cDx1rFE8ee3i8hr+hRak5k71ivXO/Y/xfktL8=;
        b=fLTiflVXvlAZUJ+l78cxIiIU7pDaqlETiwEXmtEjMlOryvhaiwWNUsSwm+StU6lV71
         +L0atj9/d6KJ8yeUb4sgxPJ1BlSuAy5JE5Wr0yziEGeZwZH4zoKhmjVT9HknfQP7wDzd
         9I6P76vWpSGUdNfZhchLKahMLjHq2eaovhqg2gzjfdEt5aCQRY98PWIPQHotEGLuZdmK
         li6SIPzvhjIfyCXESWGrghf5Wvt4Muybm2yBFF1K4yyWVnc1QOicnfz05eQQKNEAaQAE
         hUK7pMbeRSF1vMHEK/7CtR833/GH0qrrU5IiiHhYy0Y3EuqZYoLQPFWRhGM4WYN+bcQr
         euLA==
X-Forwarded-Encrypted: i=1; AJvYcCUbHvYnLpYJQbYCVh0SRFmWrXWNUJ3Ta5PbqGn1ClUOf3P809NxsTtxX4Oj0gljMlfsOkeR+lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8J2Km7fxjVLkset8tf3N0hhBZQJ3B3zEHZi8YpqyluKPRjIA
	nXStwkVR358Zjhd+jy2JW5huB0NyJK7NUQRYCz/BRuGancbarnCaCC/atKuwVnFhbps2teiKMKW
	MDFmquqPjbxcmetagfw4cQaH6ZQvRhmjAdDEZM844JOBBsB0ErtNRtx0dQA==
X-Gm-Gg: ATEYQzysE2Htmcr2p3c6Gn04Wt26xSR0qdkqXcxiQtytmhI8YUdJyF/BuveqVnhV7xG
	EJ6yHgNCC1u2QE2B1mpU6d0xAf/gyPP5xgC+DmtvNTwThZO2FpL7TrmjNvbeb/lo5q0+szfUnnr
	j2sxum926R3jk17MTclfnMaEqF01uxH7LzmYUUaFtTPRpiE5d6a/g+0fGdHakcsdTrmk3bwp0CF
	TtYjgyIKsA5ACo0K23G8MMzYBqcOgEut46uMC917irGp+jo811VSuRTmRXpD6++fqHQmG5rThbO
	sGP7l1+wNkZvb2GeX2xEt6hVIrgNlVktHukNaDztrMPytmBLloTrmr9vKMGxDCW/uzZIsv7kS9Y
	VK7DNHlEnl5I2BNtW/NKcJuR6rRBJF87sfhFABhjkkRDJ3GQYLxxZGCI6uEugSA==
X-Received: by 2002:a05:600c:6814:b0:485:3c11:de84 with SMTP id 5b1f17b1804b1-487160a2589mr54835585e9.14.1774453578658;
        Wed, 25 Mar 2026 08:46:18 -0700 (PDT)
X-Received: by 2002:a05:600c:6814:b0:485:3c11:de84 with SMTP id 5b1f17b1804b1-487160a2589mr54835085e9.14.1774453578198;
        Wed, 25 Mar 2026 08:46:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487166064fasm25225155e9.7.2026.03.25.08.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:46:17 -0700 (PDT)
Message-ID: <9e395a20-3381-475c-983a-03644a012a0c@redhat.com>
Date: Wed, 25 Mar 2026 16:46:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] drm/ast: dp501: Fix initialization of SCU2C
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-2-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-230359-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jfalempe@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: D832A328D46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 16:56, Thomas Zimmermann wrote:
> Ast's DP501 initialization reads the register SCU2C at offset 0x1202c
> and tries to set it to source data from VGA. But writes the update to
> offset 0x0, with unknown results. Write the result to SCU instead.
> 
> The bug only happens in ast_init_analog(). There's similar code in
> ast_init_dvo(), which works correctly.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 83c6620bae3f ("drm/ast: initial DP501 support (v0.2)")
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.16+
> ---
>   drivers/gpu/drm/ast/ast_dp501.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
> index 9e19d8c17730..677c52c0d99a 100644
> --- a/drivers/gpu/drm/ast/ast_dp501.c
> +++ b/drivers/gpu/drm/ast/ast_dp501.c
> @@ -436,7 +436,7 @@ static void ast_init_analog(struct ast_device *ast)
>   	/* Finally, clear bits [17:16] of SCU2c */
>   	data = ast_read32(ast, 0x1202c);
>   	data &= 0xfffcffff;
> -	ast_write32(ast, 0, data);
> +	ast_write32(ast, 0x1202c, data);
>   
>   	/* Disable DVO */
>   	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xcf, 0x00);


