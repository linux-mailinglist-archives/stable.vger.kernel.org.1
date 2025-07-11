Return-Path: <stable+bounces-161651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2729FB01BEF
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDC23B2E42
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954F29B764;
	Fri, 11 Jul 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eow4rQ24"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAB299AA4
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236762; cv=none; b=T0ONaofVjN1MPrNPVLRWNHnQNlUHhx7QtCEy4IbwmgZR+pMJL7KnLnNVyXIHj2t9bNkbRTSv6IuTEzQaKWmiY6Z6h+Cnx5/w3klMGPcX/wKwRF9ed8NQCiAW+3sXIgDjHaSh6NcveLFFrq/+iVPmWVofjCEoLiQh+4Wj6EUF52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236762; c=relaxed/simple;
	bh=L4mOUd1++E1glrzv41b5IZLOWOsB23hyMFtMeTbZeTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8OYPPkkQaftkVCVAEaGqdB6vcwqundBaEbkrE06mXY0L02EaWIs2iIeqftcdDwGeSbuAV0v+zqVXo0YSAdt+vnNfiS9aAnujpIR1qqL3iEZaR5LV46DHGcP0DKRfK2mue47QRtjyZW6VfWpX0+QYPAorM9Kwoc3y6d46VHwiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eow4rQ24; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5BE2440E021F;
	Fri, 11 Jul 2025 12:25:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2reMMpL1mpO7; Fri, 11 Jul 2025 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752236751; bh=x24BIcKFg8E0rQaaWGgUaG7qf3ydwt0ZpTCCOxf1wU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eow4rQ24dMTD7BKWM0Otlh71vk6v+jjgLuvf1JE9uJT51SrvirtF3aeXNkL+YSuSk
	 QHzrxu/zkG9tp22FagJe4LzWrhj4xH5J/PZhEzdhCoshvdqOFSi4JdZlWqb2FQnYcs
	 gCOdzdMRf8vBSmCxV5jSH8fOGewUtm9XpC69XF5vc7vBAJNyLeFTUF3gnUEfARZcQK
	 n+WGnOE6Oy8+Hpo7TFyVlqO8C9SEoVuVuH7G2bT1QH6j+B0Z5Mc60VJ25aMHWDaCid
	 rda0DDx0ppJqBXoY3ata0vbuAMbF1Xw6fhGVmf7AkxYm//aWrYrga4bqp9D+LMq5LG
	 bpP+vAOEuQReerhgWMz1iK+UxYpsTBxKCGsFBD2W8I2mok/uF6N/dsyt54jUDT5ykt
	 UodQfxhyFLQi75HadM3ZaKUKo8TXfeQc3S64SHQfu60enc73cPHPzTsWwaEspEzHoa
	 lVYcZmVY76H98AEBm9YjD7hLxg7XnKLGdVlFLf1KW/N4btHB57QnbRFVcS/lqQeXyb
	 dr9r4IEDLmxYqcDyN8RmxkYfV9TqjdJF9/yKzHTZgddec4i1ditGMI6lxCCt56td8r
	 JIxWw3Ot8I2gVMlDk34jvdTdocPpiN7SxDaFWLP6bLzdEOkPLt+qzmtjsw6gOH5gPj
	 xptHhuQUcrDqWtd8hqn47Av4=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 172BD40E0218;
	Fri, 11 Jul 2025 12:25:48 +0000 (UTC)
Date: Fri, 11 Jul 2025 14:25:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Voegtle <tv@lio96.de>
Cc: stable@vger.kernel.org, kim.phillips@amd.com
Subject: Re: TSA mitigation doesn't work on 6.6.y
Message-ID: <20250711122541.GAaHECxVpy31mIrqDb@fat_crate.local>
References: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>

On Fri, Jul 11, 2025 at 02:03:31PM +0200, Thomas Voegtle wrote:
> Is something missing in 6.6.y and 6.12.y?

I have a suspicion. Run the below patch, pls, and send me full dmesg.

Also send me your .config.

Thx.

---
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1180689a2390..104a2375c281 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -569,12 +569,15 @@ static bool amd_check_tsa_microcode(void)
 		case 0xa70c0:	min_rev = 0x0a70c008; break;
 		case 0xaa002:	min_rev = 0x0aa00216; break;
 		default:
-			pr_debug("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
+			pr_info("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
 				 __func__, p.ucode_rev, c->microcode);
 			return false;
 		}
 	}
 
+	pr_info("c->microcode: 0x%x, min_rev: 0x%x\n",
+		c->microcode, min_rev);
+
 	if (!min_rev)
 		return false;
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

