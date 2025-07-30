Return-Path: <stable+bounces-165188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC48CB15877
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 07:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD5D7A8B06
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 05:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D019E1E521E;
	Wed, 30 Jul 2025 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtgG8y7G"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2956C7462;
	Wed, 30 Jul 2025 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853745; cv=none; b=S3b9ruvb8dbPqaO6qPKmrbvxgK1XkI2VSc+ON2qRXeGLZpR6Xrpx1Sb6RGYfq8zhS3xapD0ErhsPPNb8Me+2G2voIJdy+b+/RuXSWqMmxbXPUwA09SXiMz3adRymaOpkatzRC4Ugj9PMraEjVQodkuTgTOPlDbh6ZTJ4sVGpMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853745; c=relaxed/simple;
	bh=GNrrR+zxmWPBJfDAKkGoRhAm/wUJ6NSUTG9UuP4yaC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4DLGX1qatD6CA1pGcGhqs5ql0tWcfbVx5uiU2Gw7KxbJ8whBRoo6cP9QJvz5EozmFpe5+6d7vkd2dg55QWj8J/iqjsOvfEQRL+1O3JLb9GKnuH1sbJhsyFfSW/4ybgToS+byEdh4VagUxXH+MOlwulQ4jO180sbnrlFhC8g0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtgG8y7G; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2efa219b5bbso1822426fac.0;
        Tue, 29 Jul 2025 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753853743; x=1754458543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lH3zTOxyYIDrRfVJOd6RDOdJmR7U0O0pjlTQ+4sW4aU=;
        b=VtgG8y7GTd955s9LkzmqIFIiWWnvqXYIQvizFHWKVhzyU1NergLUT4Z8AvhhRBBdW9
         rNe2BcRXOOC4qtW4wFGi4O6jOxxoY4Q3Ei4f8Ur+3DqgFcsXfIjZYu5NWEcVuteFRd0Y
         9ssrV3BHhXHzOLfpppIidT1QxiPEBgN6UVtJxHHsZTBlRKZKnQxTBxCCX20AwduXOt4D
         n8AaQ5JmZCWg7WLagEaj2/D18U+iohlNpUS+iRYxEidy+4vFtsO24cuHyAwJmOYDhUkb
         3K0ubRPwe7zCgUITqq84iBiZKPdiZYpl6s3K3i2qcwIRgLpIMrvJam7HvuvjFZFID59V
         rX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753853743; x=1754458543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lH3zTOxyYIDrRfVJOd6RDOdJmR7U0O0pjlTQ+4sW4aU=;
        b=dYqXQOg4vuCNr1kqaaIdrAcVmsYaeuNimSrpw4KaiomNxKtSAweZvU9EBmORA8LhoZ
         M20zuyAQT1PwnSeOWgFHgxpcYrHKiY4y0yBlAL9Aw7GIi+zCeAsvR2XUaYcyqs39cZUG
         pXiR79csGf4SaRd2NrIfZYpLfDMlyy1Mm1qQ97I84gzTI3m78sLUyCqY3sTDPQ1iVj4Y
         5ak0QNX8H1eY/LyMLse2uRK4dem64WQNKFmLP1a/jQptkKfR/CY6s3TyJQD+ktrAa9rV
         h2l7MgsYXhc3ccSZhgYTl2miRKQVLKNWCYVOKQZgsMxztwPEKgHKyMpX+sLYJNu0dOEj
         CFag==
X-Forwarded-Encrypted: i=1; AJvYcCUOSOqeKWcwiYB1pF3KzaCZlD9FFy9DpIvksdJzRZMIPhJGSOePw98FFvUiSXf7aRpPYXxIt7AKeuW79zw=@vger.kernel.org, AJvYcCUULdTDQv8qDmkRFYC1KywrPsg39W5iij/RRMsFIMtqGNHICo+iO0abLCj37pZGCpkzoL8TgRdx@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHoRltXJMsO9S6clyXdhnyoK0bX7BDZTKsQNNyfAOx/ZvGSqS
	ztlyc6zgEgXbVud3Bdd3Jy2ShqLEIncoXVqo/dyBQgHhwL57s7UOSl3DTV+nkcSGUYq8DEvrBMN
	hInssJl2uduMPIU43pcqOMx3BcbR7BBA=
X-Gm-Gg: ASbGncuBqnMHeFYHc0QeLs44j9iF0s7mXDoOBF8eOfWx3cCOPvKCwzxcSxOHy2P6ZuR
	VSM9oEW9+G2bzRLgnKvzd4ZCDrmft9oIG1Ih9V9sTPFlRVnc/RCNC/OfLvE6oD5vz7gamtEbmsL
	Gm7LA/rg12EjAlqd1vHKlPEhMMJ5DucI+XuQ6yzZ2kVR5i90u/BM5KbYhH0R5EM0/SCvy99C56v
	TGk5tciOwDK3punLSk77cSr9Cq+Aw==
X-Google-Smtp-Source: AGHT+IF1A1rFMCZamu2IaBoEgYcv0FlEDEcpi65mFacqaKnSqO4TFFZe9xTcpLnpa+vp2IRUARpC4oiIOFNwGDlLveM=
X-Received: by 2002:a05:687c:2bd3:b0:2ff:89c8:44f4 with SMTP id
 586e51a60fabf-30785aa2ecemr1025319fac.11.1753853743112; Tue, 29 Jul 2025
 22:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com> <2025073013-stimulus-snowdrift-d28c@gregkh>
In-Reply-To: <2025073013-stimulus-snowdrift-d28c@gregkh>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Wed, 30 Jul 2025 11:05:31 +0530
X-Gm-Features: Ac12FXzryDag2xQML-pHPGAPkTO78_sGglQTAMBlXko2uVFjAGeHnUyCAkn37bI
Message-ID: <CAO9wTFihpoVsf-SZYn6yUhCSuN9cBXFGWeGegDsS1QHk4wS7-Q@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 10:22, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 30, 2025 at 09:56:17AM +0530, Suchit Karunakaran wrote:
> > The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
> > wrong. Since INTEL_P4_PRESCOTT is numerically greater than
> > INTEL_P4_WILLAMETTE, the logic always results in false and never sets
> > X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.
> > The error was introduced while replacing the x86_model check with a VFM
> > one. The original check was as follows:
> >         if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
> >                 (c->x86 == 0x6 && c->x86_model >= 0x0e))
> >                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>
> What do you mean by "original check"?  Before the change that caused
> this, or what it should be?
>

Original check in this context refers to the change before the erroneous code.

> > Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
> > Cedarmill (model 6) which is the last model released in Family 15.
> >
> > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> >
> > Cc: <stable@vger.kernel.org> # v6.15
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>
> Nit, no blank lines beween all of those last lines.  Hint, look at all
> of the patches on the mailing lists AND in the tree already, you have
> hundreds of thousands of examples here of how to format things :)
>

Sorry about it. Should I send a new version of the patch removing the
blank lines?

