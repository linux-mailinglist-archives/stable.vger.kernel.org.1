Return-Path: <stable+bounces-191547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE2C16BC6
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 21:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A093BC9F3
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF435029D;
	Tue, 28 Oct 2025 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh5fYYx2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164B34EEEC
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682252; cv=none; b=e43q4H3EUCR9TqR/2680cVVwTD8Bl6JfPBOYgUQx4ulvqzkgl5Z2TtMahkDUxpfiUCi1/6F9Zcc8p3/eir9zlz4c7vF+6045cKPCAc9JIj0M52aJPVxqnKS0fO/cyPQhbhPQ1KmFrZU5MoNw3OOD7ZseNEUh2bKuWZ2s6Tl1lJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682252; c=relaxed/simple;
	bh=pUHPRBdDDONA/O66jwynkI4x4nubnLmx4ucFqJin5i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A408hQGe4jagraQfe49fSzUc6FEv+vlzQCtjcUGeQl6FHGAk8XMFStNe0D7NPmXeXouG/d+88NRhxaqhPV65pTc+s1FhWuHdjDPtQZVTWbt6/b2u/PpzjCEz66mp02ddBj6XUBCsng6I0ygIRDT/4+LPXMmNlX+bHuU+rk7pO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh5fYYx2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso82290066b.0
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682247; x=1762287047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYbM5VqA2h8bTAF81hKCgUCN3dB3o71pNwwlueoz59E=;
        b=lh5fYYx2+fAIwy/dZwuAMVQXWsQdr2E11XtNvcMdrtObC82HL06j7f1cgfeUlfhbOy
         TiVvZ/U40jhCvelswYDlB5aFayWJHFyCofOWlNj1wOEiJaVNt5CQV4xGRj2IwbgT5rRw
         J/hinMclNfF098+nefOJK1i+ntqDZH0YHAfDTPlvSll8dwyxmT0CgJO+CQcf3WMhn5cG
         wUZVnbGDAfRc5T82tKuUyuZKWF3VQwPcFE5krFAWTCBzMfWi0PiiqpzYE3JO4WxTG47G
         g5pIoYv4+ZFILINAPkDtQx1ewLwilNyg17VtWzOSzPyDPc2DV1cI26oaHJXfyOvQbOoe
         bQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682247; x=1762287047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYbM5VqA2h8bTAF81hKCgUCN3dB3o71pNwwlueoz59E=;
        b=te8Qyo+pr3+2t6Eu2T3vi43ZWlc60g9gLviS6cCbTQHinl4tarYvm19vO1cRftePvy
         wgpK0Z30x+Mjd5MQnbyxgJHzWKRDBZrSfZIjtrBxcv9wCKAPGwWOSDHTpj2tO0P33GPs
         6rn9Y4DHAlvliHeyFIufKJ/gTqEiHhrY0htqSd0iLIM9+VRp3funayhiF/hIRGbUSv8i
         k/ctzI/9gohUJypz72PxXmiMjmFiZnja2z2YAObEK8qX9Bs7o6Qb6bvnzTwrQBD/3eIZ
         /eqJE4s0WygE8scjMI2m8726yeFM+7WlfUI9HqKC0bPbAqsU/F2XzCaUMU90GAAgEiBx
         RJrw==
X-Forwarded-Encrypted: i=1; AJvYcCXjzW9s87P2PNPcfTTcarW2IYlq3QQHlRHxTwCwgttVs2Tf3Ym5bU/c0ilv0xTv0VaydpNlHNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwacR2BL6VqQHuQQ8bWXloMhuhilDjjeI1qfCDsZJ1lyy4FNNM+
	wmDOdGUryq5setWhyQ2pPgEK1uKDXhauwdK13wea2TI8iiJ7nSUZRJqZ
X-Gm-Gg: ASbGncs3I5i7mqN7Go3Oaw2DBYBgR2GFE3YJd3kbutICKzkuJCN3GZDTBH1oE0/iQdD
	vyJcPHmASH7SY/k5kaSRjg2IF6SCInnpOPJ9kw8Y2x0iOTq8VZtxpf3Gc6Cx7cXKKJ14LL8jy+e
	MlFpR4BMQyzsvO1MGYH+2rA+b7gTGZME1E6fh7KBwv0xjj6oQlDFzGpKa3IuAnzuL+4i/fJCUw3
	g+FsDIJqG/ch8xTd1ZnJ/Gg9AxVuoSVEctqEv2GtlxJeqTbmMVeeha3teq/6PTmZb30CTulu+w9
	gCfnCRH4AYx7NTUrtQ5gDouPiUUtNb+V4E042NLk6K6j9KCIe4ZV4tqVmcQGDB6Xkwb6oCE22pQ
	h2/WT4TpZuyK4ryX586db9/Ys7sOIbMosv5ZirBS1Ooc+0QBxio4MeIWZxEgtTPj27ParRpE/qa
	k7iFL6C2uX/tnMaOku6HrWlU++tZgmB+dVUA==
X-Google-Smtp-Source: AGHT+IE9cnCMVYrUzdBoDKJ3/QlmGC7kQ6V1NF08QBfIzmAIZdRVO+iWAw9txp7v3oAR26OFhr2WHA==
X-Received: by 2002:a17:907:7e8d:b0:b61:e088:b560 with SMTP id a640c23a62f3a-b6dbbe71f7amr433431266b.4.1761682247112;
        Tue, 28 Oct 2025 13:10:47 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8541e99fsm1202522666b.61.2025.10.28.13.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 13:10:46 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 479B3BE2EE7; Tue, 28 Oct 2025 21:10:45 +0100 (CET)
Date: Tue, 28 Oct 2025 21:10:45 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andreas Radke <andreas.radke@mailbox.org>,
	stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Zhixu Liu <zhixu.liu@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Please backport commit 00d95fcc4dee ("docs: kdoc: handle the
 obsolescensce of docutils.ErrorString()") to v6.17.y
Message-ID: <aQEjRT5JBLYiBTaL@eldamar.lan>
References: <aPUCTJx5uepKVuM9@eldamar.lan>
 <DDS2XJZB0ECJ.N4LNABSIJHAJ@mailbox.org>
 <aP4amn4YQDnzBBCU@eldamar.lan>
 <87wm4gpbw6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="93bPQ0Xi2feWC2Ni"
Content-Disposition: inline
In-Reply-To: <87wm4gpbw6.fsf@trenco.lwn.net>


--93bPQ0Xi2feWC2Ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Oct 27, 2025 at 10:06:33AM -0600, Jonathan Corbet wrote:
> Salvatore Bonaccorso <carnil@debian.org> writes:
> 
> > Hi,
> >
> > On Sun, Oct 26, 2025 at 08:36:00AM +0100, Andreas Radke wrote:
> >> For kernel 6.12 there's just one more place required to add the fix:
> >> 
> >> --- a/Documentation/sphinx/kernel_abi.py        2025-10-23 16:20:48.000000000 +0200
> >> +++ b/Documentation/sphinx/kernel_abi.py.new    2025-10-26 08:08:33.168985951 +0100
> >> @@ -42,9 +42,11 @@
> >>  from docutils import nodes, statemachine
> >>  from docutils.statemachine import ViewList
> >>  from docutils.parsers.rst import directives, Directive
> >> -from docutils.utils.error_reporting import ErrorString
> >>  from sphinx.util.docutils import switch_source_input
> >> 
> >> +def ErrorString(exc):  # Shamelessly stolen from docutils
> >> +    return f'{exc.__class__.__name}: {exc}'
> >> +
> >>  __version__  = '1.0'
> >> 
> >>  def setup(app):
> >
> > Yes this is why I asked Jonathan, how to handle backports to older
> > series, if it is wanted to pick specifically as well faccc0ec64e1
> > ("docs: sphinx/kernel_abi: adjust coding style") or a partial backport
> > of it, or do a 6.12.y backport of 00d95fcc4dee with additional
> > changes (like you pointed out).
> >
> > I'm just not sure what is preferred here. 
> 
> I'm not sure it matters that much...the additional change suggested by
> Andreas seems fine.  It's just a backport, and it shouldn't break
> anything, so doesn't seem worth a lot of worry.

Okay here is a respective backported change for the 6.12.y series as
well.

Does that look good for you?

Regards,
Salvatore

--93bPQ0Xi2feWC2Ni
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-docs-kdoc-handle-the-obsolescensce-of-docutils.Error.patch"

From aceb23b9348b98fb93a57cb70149ca8c43962aec Mon Sep 17 00:00:00 2001
From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 9 Sep 2025 13:35:37 -0600
Subject: [PATCH] docs: kdoc: handle the obsolescensce of
 docutils.ErrorString()

commit 00d95fcc4dee66dfb6980de6f2973b32f973a1eb upstream.

The ErrorString() and SafeString() docutils functions were helpers meant to
ease the handling of encodings during the Python 3 transition.  There is no
real need for them after Python 3.6, and docutils 0.22 removes them,
breaking the docs build

Handle this by just injecting our own one-liner version of ErrorString(),
and removing the sole SafeString() call entirely.

Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Message-ID: <87ldmnv2pi.fsf@trenco.lwn.net>
[ Salvatore Bonaccorso: Backport to v6.17.y for context changes in
Documentation/sphinx/kernel_include.py with major refactorings for the v6.18
development cycle. Backport ErrorString definition as well to
Documentation/sphinx/kernel_abi.py file for 6.12.y where it is imported
from docutils before the faccc0ec64e1 ("docs: sphinx/kernel_abi: adjust
coding style") change. ]
Suggested-by: Andreas Radke <andreas.radke@mailbox.org>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 Documentation/sphinx/kernel_abi.py          | 4 +++-
 Documentation/sphinx/kernel_feat.py         | 4 +++-
 Documentation/sphinx/kernel_include.py      | 6 ++++--
 Documentation/sphinx/maintainers_include.py | 4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 5911bd0d7965..51a92b371872 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -42,9 +42,11 @@ import kernellog
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-from docutils.utils.error_reporting import ErrorString
 from sphinx.util.docutils import switch_source_input
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 def setup(app):
diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index 03ace5f01b5c..2db63dd20399 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -40,9 +40,11 @@ import sys
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-from docutils.utils.error_reporting import ErrorString
 from sphinx.util.docutils import switch_source_input
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 def setup(app):
diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 638762442336..ccbddcc4af79 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -34,13 +34,15 @@ u"""
 import os.path
 
 from docutils import io, nodes, statemachine
-from docutils.utils.error_reporting import SafeString, ErrorString
 from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from docutils.parsers.rst.directives.misc import Include
 
 __version__  = '1.0'
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 # ==============================================================================
 def setup(app):
 # ==============================================================================
@@ -111,7 +113,7 @@ class KernelInclude(Include):
             raise self.severe('Problems with "%s" directive path:\n'
                               'Cannot encode input file path "%s" '
                               '(wrong locale?).' %
-                              (self.name, SafeString(path)))
+                              (self.name, path))
         except IOError as error:
             raise self.severe('Problems with "%s" directive path:\n%s.' %
                       (self.name, ErrorString(error)))
diff --git a/Documentation/sphinx/maintainers_include.py b/Documentation/sphinx/maintainers_include.py
index dcad0fff4723..496489d634c4 100755
--- a/Documentation/sphinx/maintainers_include.py
+++ b/Documentation/sphinx/maintainers_include.py
@@ -22,10 +22,12 @@ import re
 import os.path
 
 from docutils import statemachine
-from docutils.utils.error_reporting import ErrorString
 from docutils.parsers.rst import Directive
 from docutils.parsers.rst.directives.misc import Include
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 def setup(app):
-- 
2.51.0


--93bPQ0Xi2feWC2Ni--

