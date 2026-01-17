Return-Path: <stable+bounces-210142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884CD38D80
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C2063009682
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A6334C17;
	Sat, 17 Jan 2026 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muv8Df7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221FD3321AA;
	Sat, 17 Jan 2026 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643531; cv=none; b=IDX0XlRr1LAujuSLjOV/3U3eqX7f04+TLYHblEcALUrf4CcZpNtmEEx1pG0nk6HMiXYnzZ6u3yxnXii+WIj7R1dRo51VBFjJh3GGTcxLYTQyWE8ZmzpoggKJApLn1X9b3/2LK0fiCwW1G8SuL/udSxwW8OB1xOmuLvI2315/bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643531; c=relaxed/simple;
	bh=g0qCL0JoAiGU5ZstrM5vgZob9Sur8oHFKoDg1f/GvfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMYNSjwShrRrIEm5WhoJmmHuJkVpxB6jRx0sBmVFLfQB+JiSylbNs6UQtR22//XgXHL6FuRylUv2uCVqcrm11fJCx5/lRzbbyetv6TC+A5C6zwj/OsU6G7x5LHItlJjNmrEMMa5CPCGuOr6ui6RCWyR3ZEk+nYahRpCSLN1tvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muv8Df7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F08C4CEF7;
	Sat, 17 Jan 2026 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768643530;
	bh=g0qCL0JoAiGU5ZstrM5vgZob9Sur8oHFKoDg1f/GvfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=muv8Df7oZW6WDggzXF5rQMg8i6W4DKdVYV19H4d+9q2paaoS0WzDTTkz2uK3nGX+Y
	 waPLwuenyScpMWfhXYcUI5dwc2nF9Ml+lAhqzO4hbvNtMftNRqXb2StIMVwjJOPMVd
	 aSKOMi5oYfVtRMluAz3INcsdA0WxIAJWomToKdY+8Tf+jJ7WUNDDFnKxpJ9uN3WSX9
	 54d2+8h4d7eHq86o/8HxWbwHS45svC79599OsQyrzMQ0KHpnTdsNxMsmaKqtrKNkmR
	 BqpQzEwLhYhmXbCAmiMC4TXEorGCqErVPSSUhAyqqn3X0+iSAP8EsD2VPZFqgCM2rM
	 eYLBePRm+grBA==
Date: Sat, 17 Jan 2026 10:52:05 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Shuah
 Khan <skhan@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] scripts/kernel-doc: avoid error_count overflows
Message-ID: <20260117105205.14eea6e3@foz.lan>
In-Reply-To: <87ecnpo213.fsf@trenco.lwn.net>
References: <cover.1768395332.git.mchehab+huawei@kernel.org>
	<68ec6027db89b15394b8ed81b3259d1dc21ab37f.1768395332.git.mchehab+huawei@kernel.org>
	<79bb75da-5233-46d8-9590-7443806e2bd7@infradead.org>
	<87ecnpo213.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 16 Jan 2026 11:17:28 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Randy Dunlap <rdunlap@infradead.org> writes:
> 
> > Mauro,
> > The line formatting is weird on one line below
> > (looks like 2 text lines are joined).
> >
> > On 1/14/26 4:57 AM, Mauro Carvalho Chehab wrote:  
> >> The glibc library limits the return code to 8 bits. We need to
> >> stick to this limit when using sys.exit(error_count).
> >> 
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>  scripts/kernel-doc.py | 25 ++++++++++++++++++-------
> >>  1 file changed, 18 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
> >> index 7a1eaf986bcd..3992ca49d593 100755
> >> --- a/scripts/kernel-doc.py
> >> +++ b/scripts/kernel-doc.py
> >> @@ -116,6 +116,8 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
> >>  
> >>  sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
> >>  
> >> +WERROR_RETURN_CODE = 3
> >> +
> >>  DESC = """
> >>  Read C language source or header FILEs, extract embedded documentation comments,
> >>  and print formatted documentation to standard output.
> >> @@ -176,7 +178,20 @@ class MsgFormatter(logging.Formatter):
> >>          return logging.Formatter.format(self, record)
> >>  
> >>  def main():
> >> -    """Main program"""
> >> +    """
> >> +    Main program
> >> +    By default, the return value is:
> >> +
> >> +    - 0: success or Python version is not compatible with                                                                kernel-doc.  If -Werror is not used, it will also  
> >
> > Here ^^^^^
> >  
> Mauro, can you get me a clean copy?  It seems like we're more than ready
> to apply this set otherwise...

Just sent.

Ah, if you're curiously enough about autodoc, and don't want to apply
the /15 patch series, or just want to check if the docstrings are OK,
you can apply the enclosed test patch. I'm not proposing adding it
to the series, but getting issues like the above where comments look
weird is better caught by checking if the docstrings are properly
formatted and parsed by Sphinx.

Thanks,
Mauro

---

[HACK] Python autodoc test

This is just a minimal patch to place kernel-doc API documentation
somewhere (at the wrong place).

Goal here is just to easily allow testing autodoc.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 1ea2ae5c6276..bf16dd68bc62 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -18,6 +18,9 @@ import sphinx
 # documentation root, use os.path.abspath to make it absolute, like shown here.
 sys.path.insert(0, os.path.abspath("sphinx"))
 
+# Allow sphinx.ext.autodoc to document any pyhton files within the Kernel tree
+sys.path.append(os.path.abspath(".."))
+
 # Minimal supported version
 needs_sphinx = "3.4.3"
 
@@ -151,6 +154,7 @@ extensions = [
     "maintainers_include",
     "parser_yaml",
     "rstFlatTable",
+    "sphinx.ext.autodoc",
     "sphinx.ext.autosectionlabel",
     "sphinx.ext.ifconfig",
     "translations",
diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index b56128d7f5c3..7884c1297513 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -624,3 +624,11 @@ using SPHINXDIRS:
 
    When SPHINXDIRS={subdir} is used, it will only generate man pages for
    the files explicitly inside a ``Documentation/{subdir}/.../*.rst`` file.
+
+kernel\-doc docstrings documentation
+------------------------------------
+
+.. automodule:: scripts.kernel_doc
+   :members:
+   :show-inheritance:
+   :undoc-members:
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 3b6ef807791a..47eaae84adeb 120000
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1 +1 @@
-kernel-doc.py
\ No newline at end of file
+kernel_doc.py
\ No newline at end of file
diff --git a/scripts/kernel-doc.py b/scripts/kernel_doc.py
similarity index 100%
rename from scripts/kernel-doc.py
rename to scripts/kernel_doc.py


