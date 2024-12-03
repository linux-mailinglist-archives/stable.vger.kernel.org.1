Return-Path: <stable+bounces-96624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B79E20DB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D2316625A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7E1F7577;
	Tue,  3 Dec 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yJe4N1Ap"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA91F7547;
	Tue,  3 Dec 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238120; cv=none; b=Yd/Gfz8jFel+xW3dx24cVGX1ieRC8K1pKd6Pg4k3HKbLg/vkyIGJLyO0ivpGITNjGVThUTR8X6lMiDlGBwf1Z4TaXbqWOpqnZvHf8poBHpvPAUwS+u0/ZamTReFUY5rnHpCiBEhwF6rFHf1bI0iPTWFOIuTC//gIOE1d97f9ZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238120; c=relaxed/simple;
	bh=AzM2+U1Php47t+7wTLJ46JgoTWJ7vcHT9XXbaa3Flrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lzo7XpOsV+zG5xhKF+QCotf5lqvur8y8u+bUU6sVXiVqFEwlm6gMoLOTHRxq/i+KcnAw+S/vK7WSdafYXPSfRWH562nw0exbYG7qxgRLo/hDJnbLyW/tpiK3KCt1DgNLJDRQ7/oCON+py4x8ZUwsOFJqM/EyQkGC+naB4OpyLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yJe4N1Ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06E2C4CECF;
	Tue,  3 Dec 2024 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238120;
	bh=AzM2+U1Php47t+7wTLJ46JgoTWJ7vcHT9XXbaa3Flrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yJe4N1Apd//1v5lcJ59J3VKcC0h4G7SC0nLpvc1vU/uMbITGgDlc/QFbv3yM+a6cw
	 xjd7GP9yk0bMtAtbRDHkaFpa/j5t2sqpjtyHywVKDHurSLXKLjtZn/J0prJ+jJjAUX
	 Kgmgj1maKj1P4gQ+H+ksBTdsVo7HgMAq3M/xZHzI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Horia Geanta <horia.geanta@freescale.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 167/817] kernel-doc: allow object-like macros in ReST output
Date: Tue,  3 Dec 2024 15:35:39 +0100
Message-ID: <20241203144002.246811860@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit bb8fd09e2811e2386bb40b9f0d3c7dd6e7961a1e ]

output_function_rst() does not handle object-like macros. It presents
a trailing "()" while output_function_man() handles these macros
correctly.

Update output_function_rst() to handle object-like macros.
Don't show the "Parameters" heading if there are no parameters.

For output_function_man(), don't show the "ARGUMENTS" heading if there
are no parameters.

I have tested this quite a bit with my ad hoc test files for both ReST
and man format outputs. The generated output looks good.

Fixes: cbb4d3e6510b ("scripts/kernel-doc: handle object-like macros")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Horia Geanta <horia.geanta@freescale.com>
Tested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/r/20241015181107.536894-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kernel-doc | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c608820f0bf51..320544321ecba 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -569,6 +569,8 @@ sub output_function_man(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
     my $count;
+    my $func_macro = $args{'func_macro'};
+    my $paramcount = $#{$args{'parameterlist'}}; # -1 is empty
 
     print ".TH \"$args{'function'}\" 9 \"$args{'function'}\" \"$man_date\" \"Kernel Hacker's Manual\" LINUX\n";
 
@@ -600,7 +602,10 @@ sub output_function_man(%) {
         $parenth = "";
     }
 
-    print ".SH ARGUMENTS\n";
+    $paramcount = $#{$args{'parameterlist'}}; # -1 is empty
+    if ($paramcount >= 0) {
+    	print ".SH ARGUMENTS\n";
+	}
     foreach $parameter (@{$args{'parameterlist'}}) {
         my $parameter_name = $parameter;
         $parameter_name =~ s/\[.*//;
@@ -822,10 +827,16 @@ sub output_function_rst(%) {
     my $oldprefix = $lineprefix;
 
     my $signature = "";
-    if ($args{'functiontype'} ne "") {
-        $signature = $args{'functiontype'} . " " . $args{'function'} . " (";
-    } else {
-        $signature = $args{'function'} . " (";
+    my $func_macro = $args{'func_macro'};
+    my $paramcount = $#{$args{'parameterlist'}}; # -1 is empty
+
+	if ($func_macro) {
+        $signature = $args{'function'};
+	} else {
+		if ($args{'functiontype'}) {
+        	$signature = $args{'functiontype'} . " ";
+		}
+		$signature .= $args{'function'} . " (";
     }
 
     my $count = 0;
@@ -844,7 +855,9 @@ sub output_function_rst(%) {
         }
     }
 
-    $signature .= ")";
+    if (!$func_macro) {
+    	$signature .= ")";
+    }
 
     if ($sphinx_major < 3) {
         if ($args{'typedef'}) {
@@ -888,9 +901,11 @@ sub output_function_rst(%) {
     # Put our descriptive text into a container (thus an HTML <div>) to help
     # set the function prototypes apart.
     #
-    print ".. container:: kernelindent\n\n";
     $lineprefix = "  ";
-    print $lineprefix . "**Parameters**\n\n";
+	if ($paramcount >= 0) {
+    	print ".. container:: kernelindent\n\n";
+   		print $lineprefix . "**Parameters**\n\n";
+    }
     foreach $parameter (@{$args{'parameterlist'}}) {
         my $parameter_name = $parameter;
         $parameter_name =~ s/\[.*//;
@@ -1704,7 +1719,7 @@ sub check_return_section {
 sub dump_function($$) {
     my $prototype = shift;
     my $file = shift;
-    my $noret = 0;
+    my $func_macro = 0;
 
     print_lineno($new_start_line);
 
@@ -1769,7 +1784,7 @@ sub dump_function($$) {
         # declaration_name and opening parenthesis (notice the \s+).
         $return_type = $1;
         $declaration_name = $2;
-        $noret = 1;
+        $func_macro = 1;
     } elsif ($prototype =~ m/^()($name)\s*$prototype_end/ ||
         $prototype =~ m/^($type1)\s+($name)\s*$prototype_end/ ||
         $prototype =~ m/^($type2+)\s*($name)\s*$prototype_end/)  {
@@ -1796,7 +1811,7 @@ sub dump_function($$) {
     # of warnings goes sufficiently down, the check is only performed in
     # -Wreturn mode.
     # TODO: always perform the check.
-    if ($Wreturn && !$noret) {
+    if ($Wreturn && !$func_macro) {
         check_return_section($file, $declaration_name, $return_type);
     }
 
@@ -1814,7 +1829,8 @@ sub dump_function($$) {
                             'parametertypes' => \%parametertypes,
                             'sectionlist' => \@sectionlist,
                             'sections' => \%sections,
-                            'purpose' => $declaration_purpose
+                            'purpose' => $declaration_purpose,
+							'func_macro' => $func_macro
                            });
     } else {
         output_declaration($declaration_name,
@@ -1827,7 +1843,8 @@ sub dump_function($$) {
                             'parametertypes' => \%parametertypes,
                             'sectionlist' => \@sectionlist,
                             'sections' => \%sections,
-                            'purpose' => $declaration_purpose
+                            'purpose' => $declaration_purpose,
+							'func_macro' => $func_macro
                            });
     }
 }
-- 
2.43.0




