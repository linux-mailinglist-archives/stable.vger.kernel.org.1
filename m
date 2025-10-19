Return-Path: <stable+bounces-187911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D6BEE8B0
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 17:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF7346AFE
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62E31F5825;
	Sun, 19 Oct 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTsYY+Bw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2BC523A
	for <stable@vger.kernel.org>; Sun, 19 Oct 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760887379; cv=none; b=BzuhdXf6/m739Z2RwsnH96zds1WC69hzNjYyzobIgGr9KMdxFttO7uQsxVle91u+n9ltIA0b8eQv7p51z4swCQHZdIcRXtMY2VncJ3qMPATXgw5CGDPPLHAdE1FJTRP63wpT42Rz0NqZ9RMoFm8GkzwAxQ96NxXgcw2+YJ4Noxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760887379; c=relaxed/simple;
	bh=Zz92a5a6F3OLN4+cHI8/iueNB31Pm2/6LWIwcBhXKnk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WlKNfI3v8xaebdsJmml+m9Mtj1xcw9JQSL1g35O1wEXPXd1bjZz/WkxLjgQW/hvPSR+d8DsmO/PpXK/U8Y3OY5lF4e15x5/sPgvvl+UP/6D0aSK6xNZ3KsDDX0pHA99FNzMmg+AueavgOeYrt/BCn3oMRSq1oQpwleCGhOZyIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTsYY+Bw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso6430736a12.0
        for <stable@vger.kernel.org>; Sun, 19 Oct 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760887375; x=1761492175; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MSnXD2Zmi5qJWzsOosYUwmf0Z7kdjKXL81lyMDVKmyQ=;
        b=OTsYY+BwGJRW8zzGrbilunkGAF3yO78SXa5QmbRZW4uI7gG3HJSNb0InZxcYGVwbXC
         TwuT+guAJFLYZK9CjDvVv9LNg+GXyvGNuYNQ50ncmWEfIx2RzImzA7SaEKo4BxNNTEt0
         8tCXS8PhCPApLY1h6HdE4merOQwxR8hKnlUWtxFX97yrs0g33g1BtWnCorH/JDw6dVli
         ktXsuB6bu1JzwSqom4k7f94ODvcw/jBbWptD1Y/Zdl4eOovh5GewJVCo46lj/YwvNYGe
         p2U0WnGv3ypZ4TkwYMF37Bl+tItnaFtF8YCU+E1xqzUHHXuqtc8gumjo+PTHtSFVnyTJ
         ahEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760887375; x=1761492175;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSnXD2Zmi5qJWzsOosYUwmf0Z7kdjKXL81lyMDVKmyQ=;
        b=n+XtIZEGdKYSsS+hERbcMLQrFd7Z6eRWKRXcfPa/K+SkfSSmF0w0gE+PUZer+FXprW
         fUpBwwkDO7Gaf4CZvVeegQW9pHlca2dT50Kvwh2atljU4GYFxfEE8CUfKFCCzU6ELsCT
         2OslsFR7te1OikgJBt8znmst7COTYT278e7KHN6tmR1iEHx0/zcHbiMKnA9yG02Mn6Vx
         kPEpMppt9sFNir/5D0tmmYhTEOd4cYGvsLSxa8zcF+EwFfcee/XQ0/ym4M2uenmdYuTk
         bmo6LmsjnaNrRtSPSx2QajntgW7tX3LVt87VfGtPITUCi9MjPymggXdEBDS5x0gTaljE
         04Og==
X-Gm-Message-State: AOJu0Ywm+0xAYVjweijJkERxs4JKja91DWOaYbLyZ4CuAUujs+mF1x+I
	tfToHNXK9y98utDGc0NAtDXVYzSU9JwUeTIfpb8t2DUDjcr8N/Bbtwti
X-Gm-Gg: ASbGncvkmgxA3DxFvfZCV3MpC2UY3E4B1fDMF3Yz8xDg1y6cCTn/7NItEXHbMQEZ/Rw
	TipTSSbsArdlvfyE6qkaC8emm8U9DvOoZQ3IYhTxERPshTlBpt16R/DVKhvIK1QomRuQ2x7r/x9
	9jXrYZu440lN7Wgpq8o79ycpYa/Y+FUI7grtaxsW2MIPbTANSfamdyuWPi8OCM2uCDcwumEteLC
	aEJ+mfbeHj8I1NJwF7tqaEez9KR3Rw5ZbrXAp7tLgx1j/O2YP5SHghbdShrJK41jPkbddmHs4IH
	T5stMb8D6xXQurFjG9Aa34jKZnu+BfV9sQMnWExM+a7jbSTMOuPKa4IklQosB3HkmL8HQWReheH
	l7aTYwqudtVx+vjvj+uX++soSONYvyuUoDBxPbK5KouowduGrjg+X+XlcgFKQpVrdghPKjjDvvk
	+VMUeq3Kc5sRLwe/tGnLMlJqOgaLAwasCtH1abLALsON6f
X-Google-Smtp-Source: AGHT+IHuFocc8BNakcfqGS1AHLgn/UuD0B8nQBSuq2pBaAorx95IiaLxFMLNHjUTaIEuqZHKWnp/Lw==
X-Received: by 2002:a05:6402:2713:b0:62e:e5b3:6388 with SMTP id 4fb4d7f45d1cf-63c1f6b4d48mr10629131a12.19.1760887374833;
        Sun, 19 Oct 2025 08:22:54 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945f1ffsm4441882a12.31.2025.10.19.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 08:22:53 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id DB8A7BE2EE7; Sun, 19 Oct 2025 17:22:52 +0200 (CEST)
Date: Sun, 19 Oct 2025 17:22:52 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Zhixu Liu <zhixu.liu@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Please backport commit 00d95fcc4dee ("docs: kdoc: handle the
 obsolescensce of docutils.ErrorString()") to v6.17.y
Message-ID: <aPUCTJx5uepKVuM9@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8V4LYA5lItWc3kMQ"
Content-Disposition: inline


--8V4LYA5lItWc3kMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

When people update docutils to 0.22, then the Documentation build will
start failing as documented with the commit 00d95fcc4dee ("docs: kdoc:
handle the obsolescensce of docutils.ErrorString()").

So it would be nice if people can still build the documenation with
newer versions (was for instance relevant for Debian unstable for
building the 6.17.y based packages): https://bugs.debian.org/1118100

Thus can you please backport 00d95fcc4dee ("docs: kdoc: handle the
obsolescensce of docutils.ErrorString()") down to 6.17.y stable
series? The commit does not apply cleanly so adding a backport for it.

Actually it would be nice to go further back, but I just tested as
well 6.12.y and there due to missing faccc0ec64e1 ("docs:
sphinx/kernel_abi: adjust coding style") there are more work.

faccc0ec64e1 ("docs: sphinx/kernel_abi: adjust coding style") should
be applicable but I'm not sure if you want to support that. Jonathan
what would you think?

Regards,
Salvatore

--8V4LYA5lItWc3kMQ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-docs-kdoc-handle-the-obsolescensce-of-docutils.Error.patch"

From c2ce9e6de0a3dfea99de08af7b5eef5c983e76c8 Mon Sep 17 00:00:00 2001
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
[Salvatore Bonaccorso: Backport to v6.17.y for context changes in
Documentation/sphinx/kernel_include.py with major refactorings for the v6.18
development cycle]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 Documentation/sphinx/kernel_feat.py         | 4 +++-
 Documentation/sphinx/kernel_include.py      | 6 ++++--
 Documentation/sphinx/maintainers_include.py | 4 +++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index e3a51867f27b..aaac76892ceb 100644
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
index 1e566e87ebcd..641e81c58a8c 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -35,13 +35,15 @@
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
@@ -112,7 +114,7 @@ class KernelInclude(Include):
             raise self.severe('Problems with "%s" directive path:\n'
                               'Cannot encode input file path "%s" '
                               '(wrong locale?).' %
-                              (self.name, SafeString(path)))
+                              (self.name, path))
         except IOError as error:
             raise self.severe('Problems with "%s" directive path:\n%s.' %
                       (self.name, ErrorString(error)))
diff --git a/Documentation/sphinx/maintainers_include.py b/Documentation/sphinx/maintainers_include.py
index d31cff867436..519ad18685b2 100755
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


--8V4LYA5lItWc3kMQ--

